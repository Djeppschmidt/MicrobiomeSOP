# MicrobiomeSOP

A reproducible sequence analysis pipeline for Illumina amplicon data, with preliminary community analysis.

## Overview

This pipeline provides a complete, reproducible workflow for analyzing microbiome amplicon sequencing data using:

- **R and Rmarkdown**: For literate programming and reproducible analysis
- **renv**: For R package version management and reproducibility
- **DADA2**: For high-resolution sequence processing and ASV inference
- **phyloseq**: For microbiome data management and visualization

The pipeline supports both **bacterial** (16S rRNA) and **fungal** (ITS) amplicon data analysis.

## Features

- ✅ Complete DADA2 workflow from raw reads to ASV table
- ✅ Automated quality control and visualization
- ✅ Support for both bacterial and fungal taxonomy annotation
- ✅ Integrated phyloseq object creation
- ✅ Basic diversity and composition analysis
- ✅ **Advanced richness modeling** accounting for sequencing depth
- ✅ **DESeq2 differential abundance analysis** for quantitative comparisons
- ✅ Reproducible environment management with renv
- ✅ Configurable parameters via YAML
- ✅ Comprehensive tracking of reads through pipeline steps

## Installation

### Prerequisites

- R (>= 4.0.0)
- RStudio (recommended but optional)

### Setup

1. Clone this repository:
```bash
git clone https://github.com/Djeppschmidt/MicrobiomeSOP.git
cd MicrobiomeSOP
```

2. Initialize the R environment with renv:
```bash
Rscript scripts/setup_renv.R
```

This will:
- Initialize renv for package management
- Install all required R packages (dada2, phyloseq, ggplot2, etc.)
- Create a snapshot of package versions for reproducibility

Alternatively, if you have the `renv.lock` file, you can restore the exact environment:
```R
renv::restore()
```

## Test Dataset

To test your setup before analyzing your own data, you can use the **MiSeq SOP dataset** - a widely-used test dataset for microbiome analysis:

**Dataset**: [DADA2 MiSeq SOP Dataset](https://mothur.org/wiki/miseq_sop/)

This dataset contains:
- 16S rRNA V4 amplicon sequences from mouse gut microbiome
- Paired-end Illumina MiSeq reads (~20 samples)
- All necessary FASTQ files for testing the complete pipeline

**Download instructions**:
```bash
# Download the dataset
wget https://mothur.s3.us-east-2.amazonaws.com/wiki/miseqsopdata.zip
unzip miseqsopdata.zip
mv MiSeq_SOP/*fastq.gz data/raw/
```

This test dataset is ideal for validating your installation and understanding the pipeline workflow before processing your own samples.

## Usage

### 1. Prepare Your Data

Place your paired-end FASTQ files in the `data/raw/` directory with the naming convention:
- Forward reads: `SampleName_R1_001.fastq` or `SampleName_R1_001.fastq.gz`
- Reverse reads: `SampleName_R2_001.fastq` or `SampleName_R2_001.fastq.gz`

### 2. Create Sample Metadata

Edit `data/metadata/sample_metadata.csv` with your experimental metadata. The file should include:
- Sample IDs (matching FASTQ file names)
- Experimental variables (treatment groups, timepoints, etc.)

Example:
```csv
SampleID,Group,Treatment,Timepoint
Sample1,Control,None,T0
Sample2,Treated,DrugA,T0
```

### 3. Configure Analysis Parameters

Edit `config.yaml` to customize analysis parameters:

```yaml
# Set analysis type
analysis_type: "bacteria"  # or "fungi"

# Adjust DADA2 parameters
dada2:
  filter:
    truncLen: [240, 160]  # Adjust based on your read quality
    maxEE: [2, 2]
```

### 4. Download Reference Databases

For **bacterial** analysis (SILVA - recommended):
```bash
# Download SILVA v138.1 training set
wget https://zenodo.org/record/4587955/files/silva_nr99_v138.1_train_set.fa.gz
wget https://zenodo.org/record/4587955/files/silva_species_assignment_v138.1.fa.gz
```

For **fungal** analysis (UNITE):
```bash
# Download UNITE database
wget https://doi.plutof.ut.ee/doi/10.15156/BIO/2483915 -O sh_general_release_dynamic_s_all_10.05.2021.fasta
gzip sh_general_release_dynamic_s_all_10.05.2021.fasta
```

Place database files in the project root directory or update paths in `config.yaml`.

### 5. Run the Analysis

Open `analysis.Rmd` in RStudio and knit the document, or run from command line:

```bash
Rscript -e "rmarkdown::render('analysis.Rmd')"
```

This will:
1. Process raw sequences through DADA2
2. Assign taxonomy
3. Create phyloseq objects
4. Generate visualizations and summary statistics
5. Save all outputs to the `output/` directory

### 6. Extended Analysis (Optional)

For advanced downstream analyses, run the extended analysis workflow:

```bash
Rscript -e "rmarkdown::render('extended_analysis.Rmd')"
```

The extended analysis includes:
- **Richness regression modeling**: Accounts for sequencing depth effects on richness by modeling residuals from richness vs. depth regression
- **DESeq2 differential abundance analysis**: Identifies taxa with significantly different abundances between groups using quantitative methods
- PERMANOVA and beta dispersion tests
- Relative abundance calculations
- Heatmaps and co-occurrence networks
- Comprehensive data exports

## Output Files

The pipeline generates:

**Main Analysis:**
- `output/phyloseq_object.rds` - Complete phyloseq object
- `output/phyloseq_filtered.rds` - Quality-filtered phyloseq object
- `output/taxonomy.rds` - Taxonomy assignment table
- `output/figures/` - All visualization plots
- `output/tables/` - Summary tables and statistics
- `analysis.html` - Complete analysis report

**Extended Analysis (if run):**
- `output/tables/richness_regression.csv` - Richness regression results with depth-corrected values
- `output/tables/deseq2_results.csv` - Complete DESeq2 differential abundance results
- `output/tables/deseq2_significant.csv` - Significantly differentially abundant taxa only
- `extended_analysis.html` - Extended analysis report with advanced visualizations

## Project Structure

```
MicrobiomeSOP/
├── analysis.Rmd              # Main analysis workflow
├── config.yaml               # Configuration parameters
├── renv.lock                 # Package version lock file
├── .Rprofile                 # R environment setup
├── data/
│   ├── raw/                  # Raw FASTQ files (not tracked)
│   └── metadata/             # Sample metadata
├── output/                   # Analysis outputs (not tracked)
│   ├── figures/
│   └── tables/
├── scripts/
│   └── setup_renv.R          # Environment initialization script
└── README.md
```

## Customization

### Analysis Type

Switch between bacterial and fungal analysis by editing `config.yaml`:

```yaml
analysis_type: "bacteria"  # or "fungi"
```

### DADA2 Parameters

Adjust quality filtering, merging, and chimera removal parameters in `config.yaml`:

```yaml
dada2:
  filter:
    truncLen: [240, 160]  # Truncation lengths
    maxEE: [2, 2]         # Max expected errors
  merge:
    minOverlap: 12        # Minimum overlap for merging
```

### Phyloseq Filtering

Configure sample and taxa filtering thresholds:

```yaml
phyloseq:
  min_reads: 1000              # Minimum reads per sample
  prevalence_threshold: 0.05   # Minimum prevalence for taxa
```

## Reproducibility

This pipeline uses `renv` to ensure reproducibility:

- All package versions are locked in `renv.lock`
- The R version and package sources are recorded
- Anyone can recreate the exact environment with `renv::restore()`

## Troubleshooting

### Issue: Out of memory during DADA2 processing

**Solution**: Process samples in batches or increase available RAM

### Issue: Taxonomy database not found

**Solution**: Download the appropriate database and update the path in `config.yaml`

### Issue: Low read retention after filtering

**Solution**: Adjust `truncLen` and `maxEE` parameters based on quality profiles

## Citation

If you use this pipeline, please cite:

- **DADA2**: Callahan et al. (2016) Nature Methods
- **phyloseq**: McMurdie and Holmes (2013) PLoS ONE
- **SILVA**: Quast et al. (2013) Nucleic Acids Research (for bacterial analysis)
- **UNITE**: Nilsson et al. (2019) Nucleic Acids Research (for fungal analysis)

## License

This project is licensed under the terms specified in the LICENSE file.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request.

## Contact

For questions or issues, please open an issue on GitHub.

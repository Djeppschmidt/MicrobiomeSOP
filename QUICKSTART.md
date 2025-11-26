# Quick Start Guide

This guide will help you get started with the MicrobiomeSOP pipeline.

## Prerequisites

- R (version 4.0.0 or higher)
- RStudio
- GitHub Desktop installed
- At least 8GB RAM (16GB recommended for large datasets)
- Internet connection for downloading databases

## Step-by-Step Instructions

### 1. Clone the Repository

You can do this in terminal by navigating to your github directory and then running the following:

```bash
git clone https://github.com/Djeppschmidt/MicrobiomeSOP.git
cd MicrobiomeSOP
```
Alternatively, you can:
1) navigate to https://github.com/Djeppschmidt/MicrobiomeSOP
2) open the dropdown in the green button that says "Code"
2) select "Open With GitHub Desktop"

This will clone the repository into your GitHub directory

### 2. Set Up R Environment

Run the setup script to install all required packages:
1. Navigate to the scripts folder in your local copy of the MicrobiomeSOP repository
2. Open the setup_renv.R file in RStudio
3. Highlight the entire file
4. Press Command + Enter

This will:
- Install the renv package manager
- Install all required R packages (dada2, phyloseq, ggplot2, etc.)
- Create a reproducible environment snapshot

**Expected time**: less than 30 minutes for most new setups

### 3. Prepare Your Data

#### 3a. Add FASTQ Files

Place your paired-end Illumina FASTQ files in `data/raw/`:

```bash
data/raw/
├── Sample1_R1_001.fastq.gz
├── Sample1_R2_001.fastq.gz
├── Sample2_R1_001.fastq.gz
├── Sample2_R2_001.fastq.gz
...
```
There is a test data set in Data/test that you can use. The YAML is already configured for this data.


**File naming requirements**:
- Forward reads must contain `_R1_001.fastq` (or `.fastq.gz`)
- Reverse reads must contain `_R2_001.fastq` (or `.fastq.gz`)
- Sample names are extracted from the prefix before `_R1` or `_R2`

#### 3b. Create Metadata File

Edit `data/metadata/sample_metadata.csv` with your experimental design:

```csv
SampleID,Group,Treatment,Timepoint
Sample1,Control,None,T0
Sample2,Treated,DrugA,T0
Sample3,Control,None,T1
Sample4,Treated,DrugA,T1
```

**Requirements**:
- First column must be sample IDs matching FASTQ file names
- Include relevant experimental variables
- Save as CSV format

### 4. Download Reference Databases

#### For Bacterial Analysis (16S rRNA)

Download the SILVA datasets here at:
https://benjjneb.github.io/dada2/training.html

You are looking for the following files:
silva_nr99_v138.1_train_set.fa.gz and silva_species_assignment_v138.1.fa.gz

These files should be in the first link (Silva version 138.2)

Leave them in your download folder, otherwise update the path to these files in the YAML.


#### For Fungal Analysis (ITS)

Visit [UNITE database](https://doi.plutof.ut.ee/doi/10.15156/BIO/2483915) and download the general release FASTA file.

Leave these files in the download file, otherwise update the path to the files in the YAML file.

### 5. Configure Analysis Parameters

Edit `config.yaml` to match your experiment:

```yaml
# Set analysis type
analysis_type: "bacteria"  # or "fungi"

# Adjust DADA2 parameters based on your quality profiles
dada2:
  filter:
    truncLen: [240, 160]  # Adjust based on read length and quality
    maxEE: [2, 2]         # Maximum expected errors
```

**Important parameters**:
- `truncLen`: Set based on quality profiles (check after first run)
- `maxEE`: Lower values = stricter quality filtering
- Update database paths if needed

### 6. Run the Analysis

#### Option A: Using RStudio (Recommended)

1. Open `analysis.Rmd` in RStudio
2. Click "Knit" button
3. Wait for analysis to complete

#### Option B: Command Line

```bash
Rscript scripts/run_analysis.R
```

Or directly:

```bash
Rscript -e "rmarkdown::render('analysis.Rmd')"
```

**Expected time**: 
- Small dataset (<10 samples): 10-30 minutes
- Medium dataset (10-50 samples): 30-60 minutes  
- Large dataset (>50 samples): 1-3+ hours

### 7. Review Results

After completion, check:

- `analysis.html` - Complete analysis report with all visualizations
- `output/figures/` - All plots in high resolution
- `output/tables/` - Summary statistics and tracking tables
- `output/phyloseq_filtered.rds` - Final phyloseq object for further analysis

## Common Issues and Solutions

### Issue: "Cannot find database file"

**Solution**: Download the appropriate database and update the path in `config.yaml`

### Issue: "Too few reads after filtering"

**Solution**: Check quality profiles and adjust `truncLen` and `maxEE` in `config.yaml`

### Issue: "Out of memory"

**Solution**: 
- Process samples in smaller batches
- Increase available RAM
- Use a machine with more memory

### Issue: "Package installation fails"

**Solution**:
```bash
# Update R packages
Rscript -e "update.packages(ask = FALSE)"

# Reinstall renv
Rscript -e "install.packages('renv')"
Rscript scripts/setup_renv.R
```

## Next Steps

After completing the basic analysis:

1. **Explore the phyloseq object**: Load `output/phyloseq_filtered.rds` for custom analyses
2. **Statistical testing**: Add differential abundance testing
3. **Additional visualizations**: Create custom plots
4. **Metadata integration**: Analyze patterns by experimental variables

## Getting Help

- Check the [main README](README.md) for detailed documentation
- Open an issue on GitHub for bugs or feature requests
- Review the DADA2 and phyloseq documentation

## Tips for Success

- **Start small**: Test with 2-4 samples first
- **Check quality**: Always review quality profiles before setting parameters
- **Document changes**: Note any parameter modifications
- **Save work**: Commit changes to git regularly
- **Validate results**: Sanity-check read counts and taxonomy at each step

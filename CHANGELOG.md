# Changelog

All notable changes to the MicrobiomeSOP pipeline will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.1.0] - 2025-11-23

### Added
- **Richness regression analysis** in extended_analysis.Rmd
  - Models richness as a function of sequencing depth
  - Extracts residuals representing depth-corrected richness
  - ANOVA testing of depth-corrected richness by groups
  - Visualization of regression and residuals
  - Pairwise comparisons with Tukey HSD
- **DESeq2 differential abundance analysis** in extended_analysis.Rmd
  - Quantitative identification of differentially abundant taxa
  - Accounts for library size and biological variability
  - Volcano plots and MA plots
  - Bar plots of top differentially abundant taxa
  - Export of complete and significant results with taxonomy
- DESeq2 package added to renv.lock and setup script
- Updated documentation for new analyses in README and extended analysis summary

### Changed
- Extended analysis now includes richness modeling and DESeq2 analysis
- README updated with information about advanced analysis features
- Output files section expanded to include new analysis outputs

## [1.0.0] - 2025-11-23

### Added
- Initial release of MicrobiomeSOP pipeline
- Complete DADA2 workflow for sequence processing
  - Quality filtering and trimming
  - Error rate learning
  - Sample inference
  - Paired-end read merging
  - Chimera removal
  - Read tracking through pipeline
- Support for bacterial taxonomy annotation (SILVA database)
- Support for fungal taxonomy annotation (UNITE database)
- phyloseq integration for microbiome data management
- Basic diversity and composition visualizations
  - Alpha diversity plots (Shannon, Simpson, Chao1)
  - Taxonomic composition bar plots
  - PCoA ordination with Bray-Curtis distance
- renv for reproducible R environment management
- Configuration system via YAML
- Automated quality filtering of phyloseq objects
- Comprehensive documentation
  - README with installation and usage instructions
  - QUICKSTART guide for new users
  - In-code documentation
- Helper scripts
  - `setup_renv.R` - Initialize R environment
  - `run_analysis.R` - Execute analysis pipeline
  - `download_databases.sh` - Download taxonomy databases
  - `validate_setup.R` - Verify pipeline setup
- Example metadata template
- Directory structure for data organization

### Features
- Reproducible analysis workflow using Rmarkdown
- Configurable DADA2 parameters
- Support for both bacterial (16S) and fungal (ITS) amplicon data
- Automatic generation of HTML reports with visualizations
- Intermediate file saving for checkpoint/restart
- Package version locking with renv.lock

### Documentation
- Comprehensive README.md
- Quick start guide (QUICKSTART.md)
- Example metadata files
- Inline code comments and documentation
- Directory-specific README files

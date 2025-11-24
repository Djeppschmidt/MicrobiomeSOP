#!/usr/bin/env Rscript

# Script to initialize renv and install required packages

cat("Initializing renv...\n")

# Install renv if not already installed
if (!requireNamespace("renv", quietly = TRUE)) {
  install.packages("renv", repos = "https://cloud.r-project.org")
}

library(renv)

# Initialize renv project
renv::init(bare = TRUE, restart = FALSE)

cat("\nInstalling required packages...\n")

# Install Bioconductor packages
if (!requireNamespace("BiocManager", quietly = TRUE)) {
  install.packages("BiocManager", repos = "https://cloud.r-project.org")
}

# Install required packages
packages <- c(
  "dada2",      # Bioconductor
  "phyloseq",   # Bioconductor
  "DESeq2",     # Bioconductor
  "ggplot2",    # CRAN
  "yaml",       # CRAN
  "dplyr",      # CRAN
  "tidyr",      # CRAN
  "knitr",      # CRAN
  "rmarkdown",  # CRAN
  "vegan",       # CRAN - for diversity analyses
  "devtools"    #CRAN
)

# Separate Bioconductor packages from CRAN packages
bioc_packages <- c("dada2", "phyloseq", "DESeq2")
cran_packages <- setdiff(packages, bioc_packages)
github_packages <- c("djeppschmidt/QSeq")

# Install CRAN packages
if (length(cran_packages) > 0) {
  install.packages(cran_packages, repos = "https://cloud.r-project.org")
}

# Install Bioconductor packages
if (length(bioc_packages) > 0) {
  BiocManager::install(bioc_packages, update = FALSE, ask = FALSE)
}

# Install GitHub packages
install_github(github_packages)

# Take snapshot
cat("\nCreating renv snapshot...\n")
renv::snapshot(prompt = FALSE)

cat("\nrenv initialization complete!\n")
cat("Package library is now managed by renv.\n")

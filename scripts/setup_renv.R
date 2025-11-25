# Script to initialize renv and install required packages

print("Initializing renv...\n")

# Install renv if not already installed
if (!requireNamespace("renv", quietly = TRUE)) {
  install.packages("renv")
}


# Install required packages
packages <- c(
  "dada2",      # Bioconductor
  "phyloseq",   # Bioconductor
  "DESeq2",     # Bioconductor
  "BiocManager",# CRAN
  "renv",       # CRAN
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





# Install GitHub packages
# library(devtools)
# install_github(github_packages)

library(renv)

# Initialize renv project
renv::init(bare = TRUE, restart = FALSE)

# Install CRAN packages
if (length(setdiff(cran_packages, rownames(installed.packages()))) > 0) {
  renv::install(setdiff(cran_packages, rownames(installed.packages())))
}

# Install Bioconductor packages
# renv::init(bioconductor = TRUE, restart = FALSE)
if (length(bioc_packages) > 0) {
 renv::install(sapply(bioc_packages, function(x) paste0("bioc::", x)), update = FALSE, ask = FALSE)
}
# Take snapshot
print("\nCreating renv snapshot...\n")
renv::snapshot(prompt = FALSE)

print("\nrenv initialization complete!\n")
print("Package library is now managed by renv.\n")

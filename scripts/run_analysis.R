#!/usr/bin/env Rscript

# Script to run the microbiome analysis pipeline

# Load renv if available
if (file.exists("renv/activate.R")) {
  source("renv/activate.R")
}

# Check for required packages
required_packages <- c("rmarkdown", "knitr")

for (pkg in required_packages) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    cat("Error: Package", pkg, "is not installed.\n")
    cat("Please run: Rscript scripts/setup_renv.R\n")
    quit(status = 1)
  }
}

# Parse command line arguments
args <- commandArgs(trailingOnly = TRUE)

# Default to analysis.Rmd
rmd_file <- if (length(args) > 0) args[1] else "analysis.Rmd"

if (!file.exists(rmd_file)) {
  cat("Error: File", rmd_file, "not found.\n")
  quit(status = 1)
}

# Render the document
cat("Rendering", rmd_file, "...\n")

output_file <- rmarkdown::render(
  rmd_file,
  output_format = "html_document",
  quiet = FALSE
)

cat("\nAnalysis complete!\n")
cat("Output saved to:", output_file, "\n")

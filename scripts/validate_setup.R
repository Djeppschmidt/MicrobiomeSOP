#!/usr/bin/env Rscript

# Validation script to check pipeline setup

cat("MicrobiomeSOP Pipeline Validation\n")
cat("==================================\n\n")

# Check directory structure
check_dirs <- c(
  "data/raw",
  "data/metadata", 
  "output/figures",
  "output/tables",
  "scripts",
  "renv"
)

cat("Checking directory structure...\n")
all_dirs_exist <- TRUE
for (dir in check_dirs) {
  exists <- dir.exists(dir)
  status <- if (exists) "✓" else "✗"
  cat(sprintf("  %s %s\n", status, dir))
  if (!exists) all_dirs_exist <- FALSE
}

# Check required files
check_files <- c(
  "analysis.Rmd",
  "config.yaml",
  "renv.lock",
  ".Rprofile",
  "renv/activate.R",
  "data/metadata/sample_metadata.csv"
)

cat("\nChecking required files...\n")
all_files_exist <- TRUE
for (file in check_files) {
  exists <- file.exists(file)
  status <- if (exists) "✓" else "✗"
  cat(sprintf("  %s %s\n", status, file))
  if (!exists) all_files_exist <- FALSE
}

# Check if R packages would be available (without loading them)
check_packages <- c(
  "renv",
  "yaml",
  "knitr",
  "rmarkdown"
)

cat("\nChecking for basic R packages...\n")
all_packages_available <- TRUE
for (pkg in check_packages) {
  available <- suppressWarnings(requireNamespace(pkg, quietly = TRUE))
  status <- if (available) "✓" else "⚠"
  cat(sprintf("  %s %s\n", status, pkg))
  if (!available) {
    all_packages_available <- FALSE
    cat(sprintf("      Note: Run 'Rscript scripts/setup_renv.R' to install\n"))
  }
}

# Validate config.yaml
cat("\nValidating configuration...\n")
config_valid <- FALSE  # Initialize outside of conditional blocks

if (file.exists("config.yaml")) {
  tryCatch({
    config <- yaml::yaml.load_file("config.yaml")
    
    # Check required fields
    required_fields <- c("analysis_type", "dada2", "taxonomy", "metadata", "output", "phyloseq")
    config_valid <- TRUE
    
    for (field in required_fields) {
      if (field %in% names(config)) {
        cat(sprintf("  ✓ %s\n", field))
      } else {
        cat(sprintf("  ✗ Missing field: %s\n", field))
        config_valid <- FALSE
      }
    }
    
    # Check analysis type
    if ("analysis_type" %in% names(config)) {
      if (config$analysis_type %in% c("bacteria", "fungi")) {
        cat(sprintf("  ✓ Analysis type: %s\n", config$analysis_type))
      } else {
        cat(sprintf("  ⚠ Unusual analysis type: %s\n", config$analysis_type))
      }
    }
    
  }, error = function(e) {
    cat("  ✗ Error reading config.yaml:", e$message, "\n")
    config_valid <<- FALSE  # Use <<- to assign to outer scope
  })
} else {
  cat("  ✗ config.yaml not found\n")
  config_valid <- FALSE
}
}

# Summary
cat("\n==================================\n")
cat("Summary:\n")

if (all_dirs_exist) {
  cat("  ✓ Directory structure complete\n")
} else {
  cat("  ✗ Some directories missing\n")
}

if (all_files_exist) {
  cat("  ✓ Required files present\n")
} else {
  cat("  ✗ Some required files missing\n")
}

if (all_packages_available) {
  cat("  ✓ Basic packages available\n")
} else {
  cat("  ⚠ Some packages not installed\n")
  cat("    Run: Rscript scripts/setup_renv.R\n")
}

if (config_valid) {
  cat("  ✓ Configuration valid\n")
} else {
  cat("  ⚠ Configuration needs review\n")
}

cat("\n")

# Final status
if (all_dirs_exist && all_files_exist && config_valid) {
  cat("Pipeline setup is complete! ✓\n")
  cat("\nNext steps:\n")
  cat("  1. Install R packages: Rscript scripts/setup_renv.R\n")
  cat("  2. Download databases: bash scripts/download_databases.sh\n")
  cat("  3. Add your FASTQ files to data/raw/\n")
  cat("  4. Update data/metadata/sample_metadata.csv\n")
  cat("  5. Run analysis: Rscript scripts/run_analysis.R\n")
} else {
  cat("Some setup issues detected. Please review above.\n")
}

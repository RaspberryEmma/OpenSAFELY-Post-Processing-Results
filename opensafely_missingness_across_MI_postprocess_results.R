# ------------------------------------------------------------------------------
#
# opensafely_missingness_across_MI_postprocess_results.R
#
# Perform all the post processing for the opensafely missingness methods
# across multiple imputation study
#
# Authors: Emma Tarmey
#
# ------------------------------------------------------------------------------


# Refresh local R session ------------------------------------------------------
print("Refresh local R session")

rm(list=ls())


# Set working directory --------------------------------------------------------

# forces wd to be the location of this file
if (Sys.getenv("RSTUDIO") == "1") {
  setwd(dirname(rstudioapi::getSourceEditorContext()$path))
}


# Load data --------------------------------------------------------------------
print("Load data")

# cvd_missingness_methods_across_MI
across_MI_file_dir <- ""

stop("Across MI study currently running on server")


# Check data -------------------------------------------------------------------
print("Check data")


# Generate figures -------------------------------------------------------------
print("Generate figures")


# Save results -----------------------------------------------------------------
print("Save results")



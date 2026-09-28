# ------------------------------------------------------------------------------
#
# opensafely_missingness_within_MI_postprocess_results.R
#
# Perform all the post processing for the opensafely missingness methods
# within multiple imputation study
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

cvd_methods_file_dir <- "output_cvd_methods_24_09_2026/"

table1 <- read.csv(
  paste0(cvd_methods_file_dir, "table1/table1-cohort_prevax-midpoint6.csv")
)


# Check data -------------------------------------------------------------------
print("Check data")

print(head(table1))

stop("is this all the data?")


# Generate figures -------------------------------------------------------------
print("Generate figures")


# Save results -----------------------------------------------------------------
print("Save results")

write.csv(
  cvd_missingness_methods_within_MI_all_aggregate_var_selection,
  "temp/cvd_missingness_methods_within_MI_all_aggregate_var_selection.csv",
  row.names = FALSE
)

write.csv(
  cvd_missingness_methods_within_MI_all_mean_var_selection,
  "temp/cvd_missingness_methods_within_MI_all_mean_var_selection.csv",
  row.names = FALSE
)

write.csv(
  cvd_missingness_methods_within_MI_all_cox,
  "temp/cvd_missingness_methods_within_MI_all_cox.csv",
  row.names = FALSE
)

write.csv(
  cvd_missingness_methods_within_MI_unc_test_conclusion,
  "temp/cvd_missingness_methods_within_MI_unc_test_conclusion.csv",
  row.names = FALSE
)

write.csv(
  cvd_missingness_methods_within_MI_unc_test_regression,
  "temp/cvd_missingness_methods_within_MI_unc_test_regression.csv",
  row.names = FALSE
)

write.csv(
  cvd_missingness_methods_within_MI_unc_test_tests,
  "temp/cvd_missingness_methods_within_MI_unc_test_tests.csv",
  row.names = FALSE
)

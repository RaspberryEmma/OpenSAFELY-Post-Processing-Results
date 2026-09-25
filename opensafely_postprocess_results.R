# ------------------------------------------------------------------------------
#
# opensafely_postprocess_results.R
#
# Perform all the post processing for the 3 opensafely studies:
#  * cvd_methods
#  * cvd_missingness_methods
#  * cvd_missingness_methods_within_MI
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

# # cvd_methods
# cvd_methods_lasso_model_output_main <- read.csv(paste0("output_cvd_methods_24_09_2026/make_output/lasso_model_output-main-midpoint6.csv"))
# cvd_methods_lasso_model_output_main <- read.csv(paste0("output_cvd_methods_24_09_2026/make_output/lasso_model_output-main-midpoint6.csv"))

# cvd_missingness_methods_within_MI
within_MI_file_dir <- "output_cvd_missingness_methods_within_MI_23_09_2026/make_output/"

cvd_missingness_methods_within_MI_all_aggregate_var_selection <- read.csv(
  paste0(within_MI_file_dir, "all_aggregate_variable_selection_outputs.csv")
)

cvd_missingness_methods_within_MI_all_mean_var_selection <- read.csv(
  paste0(within_MI_file_dir, "all_mean_variable_selection_outputs.csv")
)

cvd_missingness_methods_within_MI_all_cox <- read.csv(
  paste0(within_MI_file_dir, "all_cox_models_outputs.csv")
)

cvd_missingness_methods_within_MI_unc_test_conclusion <- read.csv(
  paste0(within_MI_file_dir, "unconfoundedness_test_all_conclusion_tables.csv")
)

cvd_missingness_methods_within_MI_unc_test_regression <- read.csv(
  paste0(within_MI_file_dir, "unconfoundedness_test_all_regression_results.csv")
)

cvd_missingness_methods_within_MI_unc_test_tests <- read.csv(
  paste0(within_MI_file_dir, "unconfoundedness_test_all_test_tables.csv")
)


# Check data -------------------------------------------------------------------
print("Check data")

print(cvd_missingness_methods_within_MI_all_aggregate_var_selection)
print(cvd_missingness_methods_within_MI_all_mean_var_selection)
print(cvd_missingness_methods_within_MI_all_cox)
print(cvd_missingness_methods_within_MI_unc_test_conclusion)
print(cvd_missingness_methods_within_MI_unc_test_regression)
print(cvd_missingness_methods_within_MI_unc_test_tests)



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

# study population and incidence rates of outcomes
table1 <- read.csv(
  paste0(cvd_methods_file_dir, "table1/table1-cohort_prevax-midpoint6.csv")
)
table2 <- read.csv(
  paste0(cvd_methods_file_dir, "make_output/table2-sub_covidhospital_output_midpoint6.csv")
)

# analysis models
fully_adjusted_main <- read.csv(
  paste0(cvd_methods_file_dir, "make_output/model_output-main-midpoint6.csv")
)
fully_adjusted_sub_covidhospital <- read.csv(
  paste0(cvd_methods_file_dir, "make_output/model_output-sub_covidhospital-midpoint6.csv")
)
lasso_main <- read.csv(
  paste0(cvd_methods_file_dir, "make_output/lasso_model_output-main-midpoint6.csv")
)
lasso_sub_covidhospital <- read.csv(
  paste0(cvd_methods_file_dir, "make_output/lasso_model_output-sub_covidhospital-midpoint6.csv")
)
lasso_X_main <- read.csv(
  paste0(cvd_methods_file_dir, "make_output/lasso_X_model_output-main-midpoint6.csv")
)
lasso_X_sub_covidhospital <- read.csv(
  paste0(cvd_methods_file_dir, "make_output/lasso_X_model_output-sub_covidhospital-midpoint6.csv")
)
lasso_union_main <- read.csv(
  paste0(cvd_methods_file_dir, "make_output/lasso_union_model_output-main-midpoint6.csv")
)
lasso_union_sub_covidhospital <- read.csv(
  paste0(cvd_methods_file_dir, "make_output/lasso_union_model_output-sub_covidhospital-midpoint6.csv")
)

# unconfoundedness test
unc_test_conclusion <- read.csv(
  paste0(cvd_methods_file_dir, "unconfoundedness_test_all_conclusion_tables.csv")
)
unc_test_regression <- read.csv(
  paste0(cvd_methods_file_dir, "unconfoundedness_test_all_regression_results.csv")
)
unc_test_tests <- read.csv(
  paste0(cvd_methods_file_dir, "unconfoundedness_test_all_test_tables.csv")
)


# Check data -------------------------------------------------------------------
print("Check data")

print(head(table1))
print(head(table2))

print(head(fully_adjusted_main))
print(head(fully_adjusted_sub_covidhospital))
print(head(lasso_main))
print(head(lasso_sub_covidhospital))
print(head(lasso_X_main))
print(head(lasso_X_sub_covidhospital))
print(head(lasso_union_main))
print(head(lasso_union_sub_covidhospital))

print(head(unc_test_conclusion))
print(head(unc_test_regression))
print(head(unc_test_tests))

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

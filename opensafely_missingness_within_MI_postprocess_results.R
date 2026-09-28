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
print("Set working directory")

# forces wd to be the location of this file
if (Sys.getenv("RSTUDIO") == "1") {
  setwd(dirname(rstudioapi::getSourceEditorContext()$path))
}


# Import libraries -------------------------------------------------------------
print("Import libraries")

library(tidyverse)


# Load data --------------------------------------------------------------------
print("Load data")

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

print(head(cvd_missingness_methods_within_MI_all_aggregate_var_selection))
print(head(cvd_missingness_methods_within_MI_all_mean_var_selection))
print(head(cvd_missingness_methods_within_MI_all_cox))
print(head(cvd_missingness_methods_within_MI_unc_test_conclusion))
print(head(cvd_missingness_methods_within_MI_unc_test_regression))
print(head(cvd_missingness_methods_within_MI_unc_test_tests))


# Extract per-outcome and filter data ------------------------------------------
print("Extract per-outcome and filter data")

day_terms <- c(
  "days0_1", "days1_28", "days28_196", "days196_364", "days364_714",
  "days714_1582"
)

fully_adjusted_main_ami <- cvd_missingness_methods_within_MI_all_cox %>%
  dplyr::filter(method == "fully_adjusted") %>%
  dplyr::filter(name == "cohort_prevax-main-ami") %>%
  dplyr::filter(term %in% day_terms)

fully_adjusted_main_stroke_sahhs <- cvd_missingness_methods_within_MI_all_cox %>%
  dplyr::filter(method == "fully_adjusted") %>%
  dplyr::filter(name == "cohort_prevax-main-stroke_sahhs") %>%
  dplyr::filter(term %in% day_terms)

lasso_main_ami <- cvd_missingness_methods_within_MI_all_cox %>%
  dplyr::filter(method == "lasso") %>%
  dplyr::filter(name == "cohort_prevax-main-ami") %>%
  dplyr::filter(term %in% day_terms)

lasso_main_stroke_sahhs <- cvd_missingness_methods_within_MI_all_cox %>%
  dplyr::filter(method == "lasso") %>%
  dplyr::filter(name == "cohort_prevax-main-stroke_sahhs") %>%
  dplyr::filter(term %in% day_terms)

lasso_X_main_ami <- cvd_missingness_methods_within_MI_all_cox %>%
  dplyr::filter(method == "lasso_X") %>%
  dplyr::filter(name == "cohort_prevax-main-ami") %>%
  dplyr::filter(term %in% day_terms)

lasso_X_main_stroke_sahhs <- cvd_missingness_methods_within_MI_all_cox %>%
  dplyr::filter(method == "lasso_X") %>%
  dplyr::filter(name == "cohort_prevax-main-stroke_sahhs") %>%
  dplyr::filter(term %in% day_terms)

lasso_union_main_ami <- cvd_missingness_methods_within_MI_all_cox %>%
  dplyr::filter(method == "lasso_union") %>%
  dplyr::filter(name == "cohort_prevax-main-ami") %>%
  dplyr::filter(term %in% day_terms)

lasso_union_main_stroke_sahhs <- cvd_missingness_methods_within_MI_all_cox %>%
  dplyr::filter(method == "lasso_union") %>%
  dplyr::filter(name == "cohort_prevax-main-stroke_sahhs") %>%
  dplyr::filter(term %in% day_terms)


# Define time ------------------------------------------------------------------
print("Define time")

# fully_adjusted, main, ami

fully_adjusted_main_ami_times <- (((
  fully_adjusted_main_ami$term %>%
    stringr::str_remove_all("days") %>%
    stringr::str_split("_")) %>%
    do.call(rbind.data.frame, .)))
colnames(fully_adjusted_main_ami_times) <- c("period_start_days", "period_end_days")

# convert to numeric
fully_adjusted_main_ami$period_start_days <- as.numeric(fully_adjusted_main_ami_times$period_start_days)
fully_adjusted_main_ami$period_end_days   <- as.numeric(fully_adjusted_main_ami_times$period_end_days)

# define middle of period
fully_adjusted_main_ami$period_middle_days <- (
  (fully_adjusted_main_ami$period_start_days + fully_adjusted_main_ami$period_end_days)/2
)

# convert days to weeks
fully_adjusted_main_ami$period_start_weeks  <- fully_adjusted_main_ami$period_start_days / 7
fully_adjusted_main_ami$period_end_weeks    <- fully_adjusted_main_ami$period_end_days / 7
fully_adjusted_main_ami$period_middle_weeks <- fully_adjusted_main_ami$period_middle_days / 7

# exclude days_pre and day zero
# contains structural NAs
fully_adjusted_main_ami <- (
  fully_adjusted_main_ami %>%
    filter(term != "days_pre") %>%
    filter(term != "days0_1")
)

# sort by start of period time interval
fully_adjusted_main_ami <- (
  fully_adjusted_main_ami %>%
    arrange(period_start_days)
)


# fully_adjusted, main, stroke_sahhs

fully_adjusted_main_stroke_sahhs_times <- (((
  fully_adjusted_main_stroke_sahhs$term %>%
    stringr::str_remove_all("days") %>%
    stringr::str_split("_")) %>%
    do.call(rbind.data.frame, .)))
colnames(fully_adjusted_main_stroke_sahhs_times) <- c("period_start_days", "period_end_days")

# convert to numeric
fully_adjusted_main_stroke_sahhs$period_start_days <- as.numeric(fully_adjusted_main_stroke_sahhs_times$period_start_days)
fully_adjusted_main_stroke_sahhs$period_end_days   <- as.numeric(fully_adjusted_main_stroke_sahhs_times$period_end_days)

# define middle of period
fully_adjusted_main_stroke_sahhs$period_middle_days <- (
  (fully_adjusted_main_stroke_sahhs$period_start_days + fully_adjusted_main_stroke_sahhs$period_end_days)/2
)

# convert days to weeks
fully_adjusted_main_stroke_sahhs$period_start_weeks  <- fully_adjusted_main_stroke_sahhs$period_start_days / 7
fully_adjusted_main_stroke_sahhs$period_end_weeks    <- fully_adjusted_main_stroke_sahhs$period_end_days / 7
fully_adjusted_main_stroke_sahhs$period_middle_weeks <- fully_adjusted_main_stroke_sahhs$period_middle_days / 7

# exclude days_pre and day zero
# contains structural NAs
fully_adjusted_main_stroke_sahhs <- (
  fully_adjusted_main_stroke_sahhs %>%
    filter(term != "days_pre") %>%
    filter(term != "days0_1")
)

# sort by start of period time interval
fully_adjusted_main_stroke_sahhs <- (
  fully_adjusted_main_stroke_sahhs %>%
    arrange(period_start_days)
)


# lasso, main, ami

lasso_main_ami_times <- (((
  lasso_main_ami$term %>%
    stringr::str_remove_all("days") %>%
    stringr::str_split("_")) %>%
    do.call(rbind.data.frame, .)))
colnames(lasso_main_ami_times) <- c("period_start_days", "period_end_days")

# convert to numeric
lasso_main_ami$period_start_days <- as.numeric(lasso_main_ami_times$period_start_days)
lasso_main_ami$period_end_days   <- as.numeric(lasso_main_ami_times$period_end_days)

# define middle of period
lasso_main_ami$period_middle_days <- (
  (lasso_main_ami$period_start_days + lasso_main_ami$period_end_days)/2
)

# convert days to weeks
lasso_main_ami$period_start_weeks  <- lasso_main_ami$period_start_days / 7
lasso_main_ami$period_end_weeks    <- lasso_main_ami$period_end_days / 7
lasso_main_ami$period_middle_weeks <- lasso_main_ami$period_middle_days / 7

# exclude days_pre and day zero
# contains structural NAs
lasso_main_ami <- (
  lasso_main_ami %>%
    filter(term != "days_pre") %>%
    filter(term != "days0_1")
)

# sort by start of period time interval
lasso_main_ami <- (
  lasso_main_ami %>%
    arrange(period_start_days)
)


# lasso, main, stroke_sahhs

lasso_main_stroke_sahhs_times <- (((
  lasso_main_stroke_sahhs$term %>%
    stringr::str_remove_all("days") %>%
    stringr::str_split("_")) %>%
    do.call(rbind.data.frame, .)))
colnames(lasso_main_stroke_sahhs_times) <- c("period_start_days", "period_end_days")

# convert to numeric
lasso_main_stroke_sahhs$period_start_days <- as.numeric(lasso_main_stroke_sahhs_times$period_start_days)
lasso_main_stroke_sahhs$period_end_days   <- as.numeric(lasso_main_stroke_sahhs_times$period_end_days)

# define middle of period
lasso_main_stroke_sahhs$period_middle_days <- (
  (lasso_main_stroke_sahhs$period_start_days + lasso_main_stroke_sahhs$period_end_days)/2
)

# convert days to weeks
lasso_main_stroke_sahhs$period_start_weeks  <- lasso_main_stroke_sahhs$period_start_days / 7
lasso_main_stroke_sahhs$period_end_weeks    <- lasso_main_stroke_sahhs$period_end_days / 7
lasso_main_stroke_sahhs$period_middle_weeks <- lasso_main_stroke_sahhs$period_middle_days / 7

# exclude days_pre and day zero
# contains structural NAs
lasso_main_stroke_sahhs <- (
  lasso_main_stroke_sahhs %>%
    filter(term != "days_pre") %>%
    filter(term != "days0_1")
)

# sort by start of period time interval
lasso_main_stroke_sahhs <- (
  lasso_main_stroke_sahhs %>%
    arrange(period_start_days)
)


# lasso_X, main, ami

lasso_X_main_ami_times <- (((
  lasso_X_main_ami$term %>%
    stringr::str_remove_all("days") %>%
    stringr::str_split("_")) %>%
    do.call(rbind.data.frame, .)))
colnames(lasso_X_main_ami_times) <- c("period_start_days", "period_end_days")

# convert to numeric
lasso_X_main_ami$period_start_days <- as.numeric(lasso_X_main_ami_times$period_start_days)
lasso_X_main_ami$period_end_days   <- as.numeric(lasso_X_main_ami_times$period_end_days)

# define middle of period
lasso_X_main_ami$period_middle_days <- (
  (lasso_X_main_ami$period_start_days + lasso_X_main_ami$period_end_days)/2
)

# convert days to weeks
lasso_X_main_ami$period_start_weeks  <- lasso_X_main_ami$period_start_days / 7
lasso_X_main_ami$period_end_weeks    <- lasso_X_main_ami$period_end_days / 7
lasso_X_main_ami$period_middle_weeks <- lasso_X_main_ami$period_middle_days / 7

# exclude days_pre and day zero
# contains structural NAs
lasso_X_main_ami <- (
  lasso_X_main_ami %>%
    filter(term != "days_pre") %>%
    filter(term != "days0_1")
)

# sort by start of period time interval
lasso_X_main_ami <- (
  lasso_X_main_ami %>%
    arrange(period_start_days)
)


# lasso_X, main, stroke_sahhs

lasso_X_main_stroke_sahhs_times <- (((
  lasso_X_main_stroke_sahhs$term %>%
    stringr::str_remove_all("days") %>%
    stringr::str_split("_")) %>%
    do.call(rbind.data.frame, .)))
colnames(lasso_X_main_stroke_sahhs_times) <- c("period_start_days", "period_end_days")

# convert to numeric
lasso_X_main_stroke_sahhs$period_start_days <- as.numeric(lasso_X_main_stroke_sahhs_times$period_start_days)
lasso_X_main_stroke_sahhs$period_end_days   <- as.numeric(lasso_X_main_stroke_sahhs_times$period_end_days)

# define middle of period
lasso_X_main_stroke_sahhs$period_middle_days <- (
  (lasso_X_main_stroke_sahhs$period_start_days + lasso_X_main_stroke_sahhs$period_end_days)/2
)

# convert days to weeks
lasso_X_main_stroke_sahhs$period_start_weeks  <- lasso_X_main_stroke_sahhs$period_start_days / 7
lasso_X_main_stroke_sahhs$period_end_weeks    <- lasso_X_main_stroke_sahhs$period_end_days / 7
lasso_X_main_stroke_sahhs$period_middle_weeks <- lasso_X_main_stroke_sahhs$period_middle_days / 7

# exclude days_pre and day zero
# contains structural NAs
lasso_X_main_stroke_sahhs <- (
  lasso_X_main_stroke_sahhs %>%
    filter(term != "days_pre") %>%
    filter(term != "days0_1")
)

# sort by start of period time interval
lasso_X_main_stroke_sahhs <- (
  lasso_X_main_stroke_sahhs %>%
    arrange(period_start_days)
)


# lasso_union, main, ami

lasso_union_main_ami_times <- (((
  lasso_union_main_ami$term %>%
    stringr::str_remove_all("days") %>%
    stringr::str_split("_")) %>%
    do.call(rbind.data.frame, .)))
colnames(lasso_union_main_ami_times) <- c("period_start_days", "period_end_days")

# convert to numeric
lasso_union_main_ami$period_start_days <- as.numeric(lasso_union_main_ami_times$period_start_days)
lasso_union_main_ami$period_end_days   <- as.numeric(lasso_union_main_ami_times$period_end_days)

# define middle of period
lasso_union_main_ami$period_middle_days <- (
  (lasso_union_main_ami$period_start_days + lasso_union_main_ami$period_end_days)/2
)

# convert days to weeks
lasso_union_main_ami$period_start_weeks  <- lasso_union_main_ami$period_start_days / 7
lasso_union_main_ami$period_end_weeks    <- lasso_union_main_ami$period_end_days / 7
lasso_union_main_ami$period_middle_weeks <- lasso_union_main_ami$period_middle_days / 7

# exclude days_pre and day zero
# contains structural NAs
lasso_union_main_ami <- (
  lasso_union_main_ami %>%
    filter(term != "days_pre") %>%
    filter(term != "days0_1")
)

# sort by start of period time interval
lasso_union_main_ami <- (
  lasso_union_main_ami %>%
    arrange(period_start_days)
)


# lasso_union, main, stroke_sahhs

lasso_union_main_stroke_sahhs_times <- (((
  lasso_union_main_stroke_sahhs$term %>%
    stringr::str_remove_all("days") %>%
    stringr::str_split("_")) %>%
    do.call(rbind.data.frame, .)))
colnames(lasso_union_main_stroke_sahhs_times) <- c("period_start_days", "period_end_days")

# convert to numeric
lasso_union_main_stroke_sahhs$period_start_days <- as.numeric(lasso_union_main_stroke_sahhs_times$period_start_days)
lasso_union_main_stroke_sahhs$period_end_days   <- as.numeric(lasso_union_main_stroke_sahhs_times$period_end_days)

# define middle of period
lasso_union_main_stroke_sahhs$period_middle_days <- (
  (lasso_union_main_stroke_sahhs$period_start_days + lasso_union_main_stroke_sahhs$period_end_days)/2
)

# convert days to weeks
lasso_union_main_stroke_sahhs$period_start_weeks  <- lasso_union_main_stroke_sahhs$period_start_days / 7
lasso_union_main_stroke_sahhs$period_end_weeks    <- lasso_union_main_stroke_sahhs$period_end_days / 7
lasso_union_main_stroke_sahhs$period_middle_weeks <- lasso_union_main_stroke_sahhs$period_middle_days / 7

# exclude days_pre and day zero
# contains structural NAs
lasso_union_main_stroke_sahhs <- (
  lasso_union_main_stroke_sahhs %>%
    filter(term != "days_pre") %>%
    filter(term != "days0_1")
)

# sort by start of period time interval
lasso_union_main_stroke_sahhs <- (
  lasso_union_main_stroke_sahhs %>%
    arrange(period_start_days)
)


# Generate figures -------------------------------------------------------------
print("Generate figures")

# plotting
fully_adjusted_main_ami_plot <- Hmisc::errbar(
  fully_adjusted_main_ami$period_middle_weeks,
  fully_adjusted_main_ami$lnhr,
  fully_adjusted_main_ami$lnhr + fully_adjusted_main_ami$se_lnhr,
  fully_adjusted_main_ami$lnhr - fully_adjusted_main_ami$se_lnhr,
  ylim       = c(0, 3.5),
  type       = "b",
  col        = 'black',
  cex        = 2,
  errbar.col = 'green',
  main       = "Acute Myocardial Infarction, Fully Adjusted Cox-regression",
  xlab       = "Weeks since COVID19 Diagnoses",
  ylab       = "Period Specific Hazard ratio and 95% confidence interval",
  pch        = 16
)

# plotting
fully_adjusted_main_stroke_sahhs_plot <- Hmisc::errbar(
  fully_adjusted_main_stroke_sahhs$period_middle_weeks,
  fully_adjusted_main_stroke_sahhs$lnhr,
  fully_adjusted_main_stroke_sahhs$lnhr + fully_adjusted_main_stroke_sahhs$se_lnhr,
  fully_adjusted_main_stroke_sahhs$lnhr - fully_adjusted_main_stroke_sahhs$se_lnhr,
  ylim       = c(0, 3.5),
  type       = "b",
  col        = 'black',
  cex        = 2,
  errbar.col = 'green',
  main       = "Subarachnoid haemorrhage / haemorrhage stroke, Fully Adjusted Cox-regression",
  xlab       = "Weeks since COVID19 Diagnoses",
  ylab       = "Period Specific Hazard ratio and 95% confidence interval",
  pch        = 16
)

# plotting
lasso_main_ami_plot <- Hmisc::errbar(
  lasso_main_ami$period_middle_weeks,
  lasso_main_ami$lnhr,
  lasso_main_ami$lnhr + lasso_main_ami$se_lnhr,
  lasso_main_ami$lnhr - lasso_main_ami$se_lnhr,
  ylim       = c(0, 3.5),
  type       = "b",
  col        = 'black',
  cex        = 2,
  errbar.col = 'green',
  main       = "Acute Myocardial Infarction, Lasso Cox-regression",
  xlab       = "Weeks since COVID19 Diagnoses",
  ylab       = "Period Specific Hazard ratio and 95% confidence interval",
  pch        = 16
)

# plotting
lasso_main_stroke_sahhs_plot <- Hmisc::errbar(
  lasso_main_stroke_sahhs$period_middle_weeks,
  lasso_main_stroke_sahhs$lnhr,
  lasso_main_stroke_sahhs$lnhr + lasso_main_stroke_sahhs$se_lnhr,
  lasso_main_stroke_sahhs$lnhr - lasso_main_stroke_sahhs$se_lnhr,
  ylim       = c(0, 3.5),
  type       = "b",
  col        = 'black',
  cex        = 2,
  errbar.col = 'green',
  main       = "Subarachnoid haemorrhage / haemorrhage stroke, Lasso Cox-regression",
  xlab       = "Weeks since COVID19 Diagnoses",
  ylab       = "Period Specific Hazard ratio and 95% confidence interval",
  pch        = 16
)

# plotting
lasso_X_main_ami_plot <- Hmisc::errbar(
  lasso_X_main_ami$period_middle_weeks,
  lasso_X_main_ami$lnhr,
  lasso_X_main_ami$lnhr + lasso_X_main_ami$se_lnhr,
  lasso_X_main_ami$lnhr - lasso_X_main_ami$se_lnhr,
  ylim       = c(0, 3.5),
  type       = "b",
  col        = 'black',
  cex        = 2,
  errbar.col = 'green',
  main       = "Acute Myocardial Infarction, Exposure Lasso Cox-regression",
  xlab       = "Weeks since COVID19 Diagnoses",
  ylab       = "Period Specific Hazard ratio and 95% confidence interval",
  pch        = 16
)

# plotting
lasso_X_main_stroke_sahhs_plot <- Hmisc::errbar(
  lasso_X_main_stroke_sahhs$period_middle_weeks,
  lasso_X_main_stroke_sahhs$lnhr,
  lasso_X_main_stroke_sahhs$lnhr + lasso_X_main_stroke_sahhs$se_lnhr,
  lasso_X_main_stroke_sahhs$lnhr - lasso_X_main_stroke_sahhs$se_lnhr,
  ylim       = c(0, 3.5),
  type       = "b",
  col        = 'black',
  cex        = 2,
  errbar.col = 'green',
  main       = "Subarachnoid haemorrhage / haemorrhage stroke, Exposure Lasso Cox-regression",
  xlab       = "Weeks since COVID19 Diagnoses",
  ylab       = "Period Specific Hazard ratio and 95% confidence interval",
  pch        = 16
)

# plotting
lasso_union_main_ami_plot <- Hmisc::errbar(
  lasso_union_main_ami$period_middle_weeks,
  lasso_union_main_ami$lnhr,
  lasso_union_main_ami$lnhr + lasso_union_main_ami$se_lnhr,
  lasso_union_main_ami$lnhr - lasso_union_main_ami$se_lnhr,
  ylim       = c(0, 3.5),
  type       = "b",
  col        = 'black',
  cex        = 2,
  errbar.col = 'green',
  main       = "Acute Myocardial Infarction, Union Lasso Cox-regression",
  xlab       = "Weeks since COVID19 Diagnoses",
  ylab       = "Period Specific Hazard ratio and 95% confidence interval",
  pch        = 16
)

# plotting
lasso_union_main_stroke_sahhs_plot <- Hmisc::errbar(
  lasso_union_main_stroke_sahhs$period_middle_weeks,
  lasso_union_main_stroke_sahhs$lnhr,
  lasso_union_main_stroke_sahhs$lnhr + lasso_union_main_stroke_sahhs$se_lnhr,
  lasso_union_main_stroke_sahhs$lnhr - lasso_union_main_stroke_sahhs$se_lnhr,
  ylim       = c(0, 3.5),
  type       = "b",
  col        = 'black',
  cex        = 2,
  errbar.col = 'green',
  main       = "Subarachnoid haemorrhage / haemorrhage stroke, Union Lasso Cox-regression",
  xlab       = "Weeks since COVID19 Diagnoses",
  ylab       = "Period Specific Hazard ratio and 95% confidence interval",
  pch        = 16
)



# Save results -----------------------------------------------------------------
print("Save results")

# ggsave(
#   "test.tiff",
#   units="in",
#   width=5,
#   height=4,
#   dpi=300,
#   compression = 'lzw'
# )

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

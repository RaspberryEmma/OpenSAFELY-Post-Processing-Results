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


# Data processing functions ----------------------------------------------------
print("Data processing functions")

fix_names <- function(column) {
  for (i in c(1:nrow(column))) {
    column[i, ] <- str_remove(column[i, ], "cohort_prevax-")
  }
  return (column)
}

remove_outcome <- function(column) {
  for (i in c(1:nrow(column))) {
    column[i, ] <- str_remove(column[i, ], "-ami")
    column[i, ] <- str_remove(column[i, ], "-stroke_sahhs")
  }
  return (column)
}

isolate_outcome <- function(column) {
  for (i in c(1:nrow(column))) {
    if (grepl("ami", column[i, ], fixed = TRUE)) {
      column[i, ] <- "Acute MI"
    }
    else {
      column[i, ] <- "Subarachnoid haemorrhage / haemorrhage stroke"
    }
  }
  return (column)
}

replace_TRUE_with_dash <- function(column) {
  for (i in c(1:nrow(column))) {
    if (str_detect(column[i, ], "TRUE")) {
      column[i, ] <- "-"
    }
  }
  return (column)
}

table1_reorder_rows <- function(table) {
  
  table$char_and_subchar <- paste(
    table$Characteristic,
    table$Subcharacteristic,
    sep = "_"
  )
  
  table$char_and_subchar <- gsub(
    "\\s", "", table$char_and_subchar
  )
  
  order_characteristics <- c(
    "All_All",
    
    "Sex_Female",
    "Sex_Male",
    
    "Age_18-29",
    "Age_30-39",
    "Age_40-49",
    "Age_50-59",
    "Age_60-69",
    "Age_70-79",
    "Age_80-89",
    "Age_90+",
    "Age,years_Median(IQR)",
    
    "Ethnicity_Asian",
    "Ethnicity_Black",
    "Ethnicity_Missing",
    "Ethnicity_Mixed",
    "Ethnicity_Other",
    "Ethnicity_White",
    
    "Indexofmultipledeprivation_1(mostdeprived)",
    "Indexofmultipledeprivation_2",
    "Indexofmultipledeprivation_3",
    "Indexofmultipledeprivation_4",
    "Indexofmultipledeprivation_5(leastdeprived)",
    
    "Smoking_Currentsmoker",
    "Smoking_Eversmoker",
    "Smoking_Missing",
    "Smoking_Neversmoker",
    
    "Region_East",
    "Region_EastMidlands",
    "Region_London",
    "Region_NorthEast",
    "Region_NorthWest",
    "Region_SouthEast",
    "Region_SouthWest",
    "Region_WestMidlands",
    "Region_YorkshireandTheHumber",
    
    "Carehomeresident_-",
    "Healthcareworker_-",
    
    "AcuteMI_-",
    "Angina_-",
    "Cancer_-",
    "Chronickidnerydisease_-",
    "Chronicobstructivepulmonarydisease(COPD)_-",
    "Covid-19_-",
    "Dementia_-",
    "Depression_-",
    "Diabetes_-",
    "HF_-",
    "Hypertension_-",
    "Liverdisease_-",
    "Obesity_-",
    "OtherAE_-",
    "Subarachnoidhaemorrhage/haemorrhagestroke_-",
    "Stroke(all)_-",
    "Venousthromboembolismevents(VTE)_-",
    
    "AnticoagulantMed_-",
    "AntiplateletMed_-",
    "Combinedoralcontraceptivepill(COCP)_-",
    "Hormonereplacementtherapy(HRT)_-",
    "LipidMed_-"
    
  )
  
  table <- (table %>%
              mutate(char_and_subchar =  factor(char_and_subchar, levels = order_characteristics)) %>%
              arrange(char_and_subchar) %>%
              select(-one_of("char_and_subchar"))
  )
  
  return (table)
}

fix_subgroup_names <- function(column) {
  subgroup_names <- c(
    "main", "sub_covidhospital_FALSE", "sub_covidhospital_TRUE"
  )
  
  readable_subgroup_names <- c(
    "All", "Non-hospitalised COVID-19", "Hospitalised COVID-19"
  )
  
  for (i in c(1:nrow(column))) {
    if (column[i, ] %in% subgroup_names) {
      j <- which(subgroup_names == column[i, ])
      column[i, ] <- readable_subgroup_names[j]
    }
  }
  
  return (column)
}

exposure_coef_table_reorder_rows <- function(table) {
  table$name_and_method <- paste(
    table$name,
    table$method,
    sep = "_"
  )
  
  table$name_and_method <- gsub(
    "\\s", "", table$name_and_method
  )
  
  order <- c(
    "All_FullyAdjusted",
    "Non-hospitalisedCOVID-19_FullyAdjusted",
    "HospitalisedCOVID-19_FullyAdjusted",
    "All_Lasso",
    "Non-hospitalisedCOVID-19_Lasso",
    "HospitalisedCOVID-19_Lasso",
    "All_ExposureLasso",
    "Non-hospitalisedCOVID-19_ExposureLasso",
    "HospitalisedCOVID-19_ExposureLasso"
  )
  
  table <- (table %>%
              mutate(name_and_method =  factor(name_and_method, levels = order)) %>%
              arrange(name_and_method) %>%
              select(-one_of("name_and_method"))
  )
  
  return(table)
}

fix_variable_names <- function(column) {
  var_names <- c(
    "cov_bin_ami", "cov_cat_age_group",
    "cov_bin_sahhs", "cov_bin_covid", "cov_num_age", "cov_cat_sex", "cov_cat_ethnicity",
    "cov_cat_imd", "cov_cat_smoking", "cov_bin_carehome", "cov_bin_hcworker", "cov_bin_dementia",
    "cov_bin_liver_disease", "cov_bin_ckd", "cov_bin_cancer", "cov_bin_hypertension", "cov_bin_diabetes",
    "cov_bin_obesity", "cov_bin_copd", "cov_bin_depression", "cov_bin_stroke_all", "cov_bin_other_ae",
    "cov_bin_vte", "cov_bin_hf", "cov_bin_angina", "cov_bin_lipidmed", "cov_bin_antiplatelet",
    "cov_bin_anticoagulant", "cov_bin_cocp", "cov_bin_hrt", "strat_cat_region"
  )
  
  readable_var_names <- c(
    "Acute MI", "Age",
    "Subarachnoid haemorrhage / haemorrhage stroke", "Covid-19", "Age", "Sex", "Ethnicity",
    "Index of multiple deprivation", "Smoking", "Carehome resident", "Healthcare worker", "Dementia",
    "Liver disease", "Chronic kidney disease", "Cancer", "Hypertension", "Diabetes",
    "Obesity", "Chronic obstructive pulmonary disease (COPD)", "Depression", "Stroke (all)", "Other AE",
    "Venous thromboembolism events (VTE)", "HF", "Angina", "Lipid Med", "Antiplatelet Med",
    "Anticoagulant Med", "Combined oral contraceptive pill (COCP)", "Hormone replacement therapy (HRT)", "Region"
  )
  
  for (i in c(1:nrow(column))) {
    if (column[i, ] %in% var_names) {
      j <- which(var_names == column[i, ])
      column[i, ] <- readable_var_names[j]
    }
  }
  
  return(column)
}

fix_variable_with_level_names <- function(column) {
  var_names <- c(
    "(Intercept)",
    "cov_bin_sahhsTRUE",
    "cov_num_age",
    "cov_cat_sexMale",
    "cov_cat_ethnicityAsian",
    "cov_cat_ethnicityBlack",
    "cov_cat_ethnicityMissing",
    "cov_cat_ethnicityMixed",
    "cov_cat_ethnicityOther",
    "cov_cat_imd.L",
    "cov_cat_imd.Q",
    "cov_cat_imd.C",
    "cov_cat_imd^4",
    "cov_cat_smoking.L",
    "cov_cat_smoking.Q",
    "cov_cat_smoking.C",
    "cov_bin_carehomeTRUE",
    "cov_bin_hcworkerTRUE",
    "cov_bin_dementiaTRUE",
    "cov_bin_liver_diseaseTRUE",
    "cov_bin_ckdTRUE",
    "cov_bin_cancerTRUE",
    "cov_bin_hypertensionTRUE",
    "cov_bin_diabetesTRUE",
    "cov_bin_obesityTRUE",
    "cov_bin_copdTRUE",
    "cov_bin_depressionTRUE",
    "cov_bin_stroke_allTRUE",
    "cov_bin_other_aeTRUE",
    "cov_bin_vteTRUE",
    "cov_bin_hfTRUE",
    "cov_bin_anginaTRUE",
    "cov_bin_lipidmedTRUE",
    "cov_bin_antiplateletTRUE",
    "cov_bin_anticoagulantTRUE",
    "cov_bin_cocpTRUE",
    "cov_bin_hrtTRUE",
    "strat_cat_regionEast Midlands",
    "strat_cat_regionLondon",
    "strat_cat_regionNorth East",
    "strat_cat_regionNorth West",
    "strat_cat_regionSouth East",
    "strat_cat_regionSouth West",
    "strat_cat_regionWest Midlands",
    "strat_cat_regionYorkshire and The Humber",
    "cov_bin_amiTRUE",
    "cov_bin_covidTRUE"
  )
  
  readable_var_names <- c(
    "(Intercept)",
    "Subarachnoid haemorrhage / haemorrhage stroke",
    "Age",
    "Sex (Male)",
    
    "Ethnicity (Asian)",
    "Ethnicity (Black)",
    "Ethnicity (Missing)",
    "Ethnicity (Mixed)",
    "Ethnicity (Other)",
    
    "Index of multiple deprivation (L)",
    "Index of multiple deprivation (Q)",
    "Index of multiple deprivation (C)",
    "Index of multiple deprivation (^4)",
    
    "Smoking (L)",
    "Smoking (Q)",
    "Smoking (C)",
    
    "Carehome resident",
    "Healthcare worker",
    "Dementia",
    "Liver disease",
    "Chronic kidney disease",
    "Cancer",
    "Hypertension",
    "Diabetes",
    "Obesity",
    "Chronic obstructive pulmonary disease (COPD)",
    "Depression",
    "Stroke (all)",
    "Other AE",
    "Venous thromboembolism events (VTE)",
    "HF",
    "Angina",
    "Lipid Med",
    "Antiplatelet Med",
    "Anticoagulant Med",
    "Combined oral contraceptive pill (COCP)",
    "Hormone replacement therapy (HRT)",
    
    "Region (East Midlands)",
    "Region (London)",
    "Region (North East)",
    "Region (North West)",
    "Region (South East)",
    "Region (South West)",
    "Region (West Midlands)",
    "Region (Yorkshire and The Humber)",
    
    "Acute MI",
    "Covid-19"
    
  )
  
  for (i in c(1:nrow(column))) {
    if (column[i, ] %in% var_names) {
      j <- which(var_names == column[i, ])
      column[i, ] <- readable_var_names[j]
    }
  }
  
  return(column)
}

fix_vars_list <- function(column) {
  var_names <- c(
    "cov_bin_ami", "cov_cat_age_group",
    "cov_bin_sahhs", "cov_bin_covid", "cov_num_age", "cov_cat_sex", "cov_cat_ethnicity",
    "cov_cat_imd", "cov_cat_smoking", "cov_bin_carehome", "cov_bin_hcworker", "cov_bin_dementia",
    "cov_bin_liver_disease", "cov_bin_ckd", "cov_bin_cancer", "cov_bin_hypertension", "cov_bin_diabetes",
    "cov_bin_obesity", "cov_bin_copd", "cov_bin_depression", "cov_bin_stroke_all", "cov_bin_other_ae",
    "cov_bin_vte", "cov_bin_hf", "cov_bin_angina", "cov_bin_lipidmed", "cov_bin_antiplatelet",
    "cov_bin_anticoagulant", "cov_bin_cocp", "cov_bin_hrt", "strat_cat_region",
    "end_date_exposure", "binary_covid19_exposure"
  )
  
  readable_var_names <- c(
    "Acute MI", "Age",
    "Subarachnoid haemorrhage / haemorrhage stroke", "Covid-19", "Age", "Sex", "Ethnicity",
    "Index of multiple deprivation", "Smoking", "Carehome resident", "Healthcare worker", "Dementia",
    "Liver disease", "Chronic kidney disease", "Cancer", "Hypertension", "Diabetes",
    "Obesity", "Chronic obstructive pulmonary disease (COPD)", "Depression", "Stroke (all)", "Other AE",
    "Venous thromboembolism events (VTE)", "HF", "Angina", "Lipid Med", "Antiplatelet Med",
    "Anticoagulant Med", "Combined oral contraceptive pill (COCP)", "Hormone replacement therapy (HRT)", "Region",
    "End Date Exposure", "Exposure Indicator"
  )
  
  for (i in c(1:nrow(column))) {
    current_vars_list <- str_split(column[i, ], ";")[[1]]
    
    for (j in c(1:length(current_vars_list))) {
      if (current_vars_list[j] %in% var_names) {
        k <- which(var_names == current_vars_list[j])
        current_vars_list[j] <- readable_var_names[k]
      }
    }
    
    readable_vars_list <- paste(current_vars_list, collapse = ", ")
    column[i, ]        <- readable_vars_list
  }
  
  return(column)
}

fix_method_names <- function(column) {
  method_names <- c(
    "fully_adjusted", "Fully-adjusted",
    "lasso", "Lasso",
    "lasso_X", "Lasso_X",
    "Lasso_union", "lasso_union"
  )
  
  readable_method_names <- c(
    "Fully Adjusted", "Fully Adjusted",
    "Lasso", "Lasso",
    "Exposure Lasso", "Exposure Lasso",
    "Union Lasso", "Union Lasso"
  )
  
  for (i in c(1:nrow(column))) {
    if (column[i, ] %in% method_names) {
      j <- which(method_names == column[i, ])
      column[i, ] <- readable_method_names[j]
    }
  }
  
  return(column)
}

fix_time_names <- function(column) {
  time_names <- c(
    "days0_1", "days1_28", "days28_196", "days196_364", "days364_714", "days714_1582"
  )
  
  readable_time_names <- c(
    "Day 0", "1-4 weeks", "5-28 weeks", "29-52 weeks", "53-102 weeks", "103-204 weeks"
  )
  
  for (i in c(1:nrow(column))) {
    if (column[i, ] %in% time_names) {
      j <- which(time_names == column[i, ])
      column[i, ] <- readable_time_names[j]
    }
  }
  
  return (column)
}

round_to_three_sf <- function(column) {
  for (i in c(1:nrow(column))) {
    column[i, ] <- signif(column[i, ], digits = 3)
  }
  
  return (column)
}



# Post-processing --------------------------------------------------------------
print("Post-processing")

readable_time_names <- c(
  "Day 0", "1-4 weeks", "5-28 weeks", "29-52 weeks", "53-102 weeks", "103-204 weeks"
)

cvd_missingness_methods_within_MI_all_cox["outcome"] <- cvd_missingness_methods_within_MI_all_cox["name"]
cvd_missingness_methods_within_MI_all_cox["outcome"] <- isolate_outcome(cvd_missingness_methods_within_MI_all_cox["outcome"])
cvd_missingness_methods_within_MI_all_cox["name"]    <- fix_names(cvd_missingness_methods_within_MI_all_cox["name"])
cvd_missingness_methods_within_MI_all_cox["name"]    <- remove_outcome(cvd_missingness_methods_within_MI_all_cox["name"])
cvd_missingness_methods_within_MI_all_cox["name"]    <- fix_subgroup_names(cvd_missingness_methods_within_MI_all_cox["name"])
cvd_missingness_methods_within_MI_all_cox["method"]  <- fix_method_names(cvd_missingness_methods_within_MI_all_cox["method"])
cvd_missingness_methods_within_MI_all_cox["term"]    <- fix_time_names(cvd_missingness_methods_within_MI_all_cox["term"])
cvd_missingness_methods_within_MI_all_cox["lnhr"]    <- round_to_three_sf(cvd_missingness_methods_within_MI_all_cox["lnhr"])
cvd_missingness_methods_within_MI_all_cox["se_lnhr"] <- round_to_three_sf(cvd_missingness_methods_within_MI_all_cox["se_lnhr"])
cvd_missingness_methods_within_MI_all_cox            <- exposure_coef_table_reorder_rows(cvd_missingness_methods_within_MI_all_cox)

cvd_missingness_methods_within_MI_all_cox_ami <- cvd_missingness_methods_within_MI_all_cox %>%
  dplyr::filter(outcome == "Acute MI") %>%
  dplyr::filter(term %in% readable_time_names) %>%
  dplyr::select(method, name, term, lnhr, se_lnhr)

cvd_missingness_methods_within_MI_all_cox_stroke_sahhs <- cvd_missingness_methods_within_MI_all_cox %>%
  dplyr::filter(outcome == "Subarachnoid haemorrhage / haemorrhage stroke") %>%
  dplyr::filter(term %in% readable_time_names) %>%
  dplyr::select(method, name, term, lnhr, se_lnhr)

cvd_missingness_methods_within_MI_unc_test_conclusion["outcome"] <- cvd_missingness_methods_within_MI_unc_test_conclusion["name"]
cvd_missingness_methods_within_MI_unc_test_conclusion["outcome"] <- isolate_outcome(cvd_missingness_methods_within_MI_unc_test_conclusion["outcome"])
cvd_missingness_methods_within_MI_unc_test_conclusion["name"]    <- fix_names(cvd_missingness_methods_within_MI_unc_test_conclusion["name"])
cvd_missingness_methods_within_MI_unc_test_conclusion["name"]    <- remove_outcome(cvd_missingness_methods_within_MI_unc_test_conclusion["name"])
cvd_missingness_methods_within_MI_unc_test_conclusion["name"]    <- fix_subgroup_names(cvd_missingness_methods_within_MI_unc_test_conclusion["name"])
cvd_missingness_methods_within_MI_unc_test_conclusion["method"]  <- fix_method_names(cvd_missingness_methods_within_MI_unc_test_conclusion["method"])

cvd_missingness_methods_within_MI_unc_test_conclusion <- cvd_missingness_methods_within_MI_unc_test_conclusion %>%
  dplyr::select(outcome, name, method, test_result, interpretation)


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
  cvd_missingness_methods_within_MI_all_cox_ami,
  "temp/cvd_missingness_methods_within_MI_all_cox_ami.csv",
  row.names = FALSE
)

write.csv(
  cvd_missingness_methods_within_MI_all_cox_stroke_sahhs,
  "temp/cvd_missingness_methods_within_MI_all_cox_stroke_sahhs.csv",
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

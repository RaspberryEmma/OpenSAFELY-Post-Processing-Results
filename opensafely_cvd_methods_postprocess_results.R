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


# Import libraries -------------------------------------------------------------

library(tidyverse)


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
  paste0(cvd_methods_file_dir, "make_output/unconfoundedness_test_all_conclusion_tables.csv")
)
unc_test_regression <- read.csv(
  paste0(cvd_methods_file_dir, "make_output/unconfoundedness_test_all_regression_results.csv")
)
unc_test_tests <- read.csv(
  paste0(cvd_methods_file_dir, "make_output/unconfoundedness_test_all_test_tables.csv")
)

# variable selection models
fully_adjusted_var_sel_main_ami <- read.csv(
  paste0(cvd_methods_file_dir, "lasso_var_selection/fully_adjusted_cox_coefs-cohort_prevax-main-ami.csv")
)
fully_adjusted_var_sel_main_stroke_sahhs <- read.csv(
  paste0(cvd_methods_file_dir, "lasso_var_selection/fully_adjusted_cox_coefs-cohort_prevax-main-stroke_sahhs.csv")
)
fully_adjusted_var_sel_sub_covidhospital_FALSE_ami <- read.csv(
  paste0(cvd_methods_file_dir, "lasso_var_selection/fully_adjusted_cox_coefs-cohort_prevax-sub_covidhospital_FALSE-ami.csv")
)
fully_adjusted_var_sel_sub_covidhospital_FALSE_stroke_sahhs <- read.csv(
  paste0(cvd_methods_file_dir, "lasso_var_selection/fully_adjusted_cox_coefs-cohort_prevax-sub_covidhospital_FALSE-stroke_sahhs.csv")
)
fully_adjusted_var_sel_sub_covidhospital_TRUE_ami <- read.csv(
  paste0(cvd_methods_file_dir, "lasso_var_selection/fully_adjusted_cox_coefs-cohort_prevax-sub_covidhospital_TRUE-ami.csv")
)
fully_adjusted_var_sel_sub_covidhospital_TRUE_stroke_sahhs <- read.csv(
  paste0(cvd_methods_file_dir, "lasso_var_selection/fully_adjusted_cox_coefs-cohort_prevax-sub_covidhospital_TRUE-stroke_sahhs.csv")
)

lasso_var_sel_main_ami <- read.csv(
  paste0(cvd_methods_file_dir, "lasso_var_selection/lasso_var_selection-coefs-cohort_prevax-main-ami.csv")
)
lasso_var_sel_main_stroke_sahhs <- read.csv(
  paste0(cvd_methods_file_dir, "lasso_var_selection/lasso_var_selection-coefs-cohort_prevax-main-stroke_sahhs.csv")
)
lasso_var_sel_sub_covidhospital_FALSE_ami <- read.csv(
  paste0(cvd_methods_file_dir, "lasso_var_selection/lasso_var_selection-coefs-cohort_prevax-sub_covidhospital_FALSE-ami.csv")
)
lasso_var_sel_sub_covidhospital_FALSE_stroke_sahhs <- read.csv(
  paste0(cvd_methods_file_dir, "lasso_var_selection/lasso_var_selection-coefs-cohort_prevax-sub_covidhospital_FALSE-stroke_sahhs.csv")
)
lasso_var_sel_sub_covidhospital_TRUE_ami <- read.csv(
  paste0(cvd_methods_file_dir, "lasso_var_selection/lasso_var_selection-coefs-cohort_prevax-sub_covidhospital_TRUE-ami.csv")
)
lasso_var_sel_sub_covidhospital_TRUE_stroke_sahhs <- read.csv(
  paste0(cvd_methods_file_dir, "lasso_var_selection/lasso_var_selection-coefs-cohort_prevax-sub_covidhospital_TRUE-stroke_sahhs.csv")
)

fully_adjusted_logistic_var_sel_main_ami <- read.csv(
  paste0(cvd_methods_file_dir, "lasso_X_var_selection/fully_adjusted_logistic_coefs-cohort_prevax-main-ami.csv")
)
fully_adjusted_logistic_var_sel_main_stroke_sahhs <- read.csv(
  paste0(cvd_methods_file_dir, "lasso_X_var_selection/fully_adjusted_logistic_coefs-cohort_prevax-main-stroke_sahhs.csv")
)
fully_adjusted_logistic_var_sel_sub_covidhospital_FALSE_ami <- read.csv(
  paste0(cvd_methods_file_dir, "lasso_X_var_selection/fully_adjusted_logistic_coefs-cohort_prevax-sub_covidhospital_FALSE-ami.csv")
)
fully_adjusted_logistic_var_sel_sub_covidhospital_FALSE_stroke_sahhs <- read.csv(
  paste0(cvd_methods_file_dir, "lasso_X_var_selection/fully_adjusted_logistic_coefs-cohort_prevax-sub_covidhospital_FALSE-stroke_sahhs.csv")
)
fully_adjusted_logistic_var_sel_sub_covidhospital_TRUE_ami <- read.csv(
  paste0(cvd_methods_file_dir, "lasso_X_var_selection/fully_adjusted_logistic_coefs-cohort_prevax-sub_covidhospital_TRUE-ami.csv")
)
fully_adjusted_logistic_var_sel_sub_covidhospital_TRUE_stroke_sahhs <- read.csv(
  paste0(cvd_methods_file_dir, "lasso_X_var_selection/fully_adjusted_logistic_coefs-cohort_prevax-sub_covidhospital_TRUE-stroke_sahhs.csv")
)

lasso_X_var_sel_main_ami <- read.csv(
  paste0(cvd_methods_file_dir, "lasso_X_var_selection/lasso_X_var_selection-coefs-cohort_prevax-main-ami.csv")
)
lasso_X_var_sel_main_stroke_sahhs <- read.csv(
  paste0(cvd_methods_file_dir, "lasso_X_var_selection/lasso_X_var_selection-coefs-cohort_prevax-main-stroke_sahhs.csv")
)
lasso_X_var_sel_sub_covidhospital_FALSE_ami <- read.csv(
  paste0(cvd_methods_file_dir, "lasso_X_var_selection/lasso_X_var_selection-coefs-cohort_prevax-sub_covidhospital_FALSE-ami.csv")
)
lasso_X_var_sel_sub_covidhospital_FALSE_stroke_sahhs <- read.csv(
  paste0(cvd_methods_file_dir, "lasso_X_var_selection/lasso_X_var_selection-coefs-cohort_prevax-sub_covidhospital_FALSE-stroke_sahhs.csv")
)
lasso_X_var_sel_sub_covidhospital_TRUE_ami <- read.csv(
  paste0(cvd_methods_file_dir, "lasso_X_var_selection/lasso_X_var_selection-coefs-cohort_prevax-sub_covidhospital_TRUE-ami.csv")
)
lasso_X_var_sel_sub_covidhospital_TRUE_stroke_sahhs <- read.csv(
  paste0(cvd_methods_file_dir, "lasso_X_var_selection/lasso_X_var_selection-coefs-cohort_prevax-sub_covidhospital_TRUE-stroke_sahhs.csv")
)


# Check data -------------------------------------------------------------------
print("Check data")

# # tables
# print(head(table1))
# print(head(table2))
# 
# # analysis models
# print(head(fully_adjusted_main))
# print(head(fully_adjusted_sub_covidhospital))
# print(head(lasso_main))
# print(head(lasso_sub_covidhospital))
# print(head(lasso_X_main))
# print(head(lasso_X_sub_covidhospital))
# print(head(lasso_union_main))
# print(head(lasso_union_sub_covidhospital))
# 
# # unconfoundedness tests
# print(head(unc_test_conclusion))
# print(head(unc_test_regression))
# print(head(unc_test_tests))
# 
# # variable selection models
# print(head(fully_adjusted_var_sel_main_ami))
# print(head(fully_adjusted_var_sel_main_stroke_sahhs))
# print(head(fully_adjusted_var_sel_sub_covidhospital_FALSE_ami))
# print(head(fully_adjusted_var_sel_sub_covidhospital_FALSE_stroke_sahhs))
# print(head(fully_adjusted_var_sel_sub_covidhospital_TRUE_ami))
# print(head(fully_adjusted_var_sel_sub_covidhospital_TRUE_stroke_sahhs))
# 
# print(head(lasso_var_sel_main_ami))
# print(head(lasso_var_sel_main_stroke_sahhs))
# print(head(lasso_var_sel_sub_covidhospital_FALSE_ami))
# print(head(lasso_var_sel_sub_covidhospital_FALSE_stroke_sahhs))
# print(head(lasso_var_sel_sub_covidhospital_TRUE_ami))
# print(head(lasso_var_sel_sub_covidhospital_TRUE_stroke_sahhs))
# 
# print(head(fully_adjusted_logistic_var_sel_main_ami))
# print(head(fully_adjusted_logistic_var_sel_main_stroke_sahhs))
# print(head(fully_adjusted_logistic_var_sel_sub_covidhospital_FALSE_ami))
# print(head(fully_adjusted_logistic_var_sel_sub_covidhospital_FALSE_stroke_sahhs))
# print(head(fully_adjusted_logistic_var_sel_sub_covidhospital_TRUE_ami))
# print(head(fully_adjusted_logistic_var_sel_sub_covidhospital_TRUE_stroke_sahhs))
# 
# print(head(lasso_X_var_sel_main_ami))
# print(head(lasso_X_var_sel_main_stroke_sahhs))
# print(head(lasso_X_var_sel_sub_covidhospital_FALSE_ami))
# print(head(lasso_X_var_sel_sub_covidhospital_FALSE_stroke_sahhs))
# print(head(lasso_X_var_sel_sub_covidhospital_TRUE_ami))
# print(head(lasso_X_var_sel_sub_covidhospital_TRUE_stroke_sahhs))


# Generate figures -------------------------------------------------------------
print("Generate figures")


# Exposure coefficients ami all models -----------------------------------------
print("Exposure coefficients ami all models")

day_terms <- c(
  "days0_1", "days1_28", "days28_196", "days196_364", "days364_714",
  "days714_1582"
)

# fully_adjusted

fully_adjusted_main_ami_exposure <- fully_adjusted_main %>%
  dplyr::filter(model == "mdl_max_adj") %>%
  dplyr::filter(term %in% day_terms) %>%
  dplyr::filter(outcome == "ami") %>%
  arrange(sapply(term, function(y) which(y == day_terms)))

fully_adjusted_main_ami_exposure["method"] <- "fully_adjusted"

fully_adjusted_main_ami_exposure <- fully_adjusted_main_ami_exposure %>%
  dplyr::select(name, method, term, lnhr)

fully_adjusted_sub_covidhospital_ami_exposure <- fully_adjusted_sub_covidhospital %>%
  dplyr::filter(model == "mdl_max_adj") %>%
  dplyr::filter(term %in% day_terms) %>%
  dplyr::filter(outcome == "ami") %>%
  arrange(sapply(term, function(y) which(y == day_terms)))

fully_adjusted_sub_covidhospital_ami_exposure["method"] <- "fully_adjusted"

fully_adjusted_sub_covidhospital_ami_exposure <- fully_adjusted_sub_covidhospital_ami_exposure %>%
  dplyr::select(name, method, term, lnhr)


# lasso

lasso_main_ami_exposure <- lasso_main %>%
  dplyr::filter(model == "mdl_max_adj") %>%
  dplyr::filter(term %in% day_terms) %>%
  dplyr::filter(outcome == "ami") %>%
  arrange(sapply(term, function(y) which(y == day_terms)))

lasso_main_ami_exposure["method"] <- "lasso"

lasso_main_ami_exposure <- lasso_main_ami_exposure %>%
  dplyr::select(name, method, term, lnhr)

lasso_sub_covidhospital_ami_exposure <- lasso_sub_covidhospital %>%
  dplyr::filter(model == "mdl_max_adj") %>%
  dplyr::filter(term %in% day_terms) %>%
  dplyr::filter(outcome == "ami") %>%
  arrange(sapply(term, function(y) which(y == day_terms)))

lasso_sub_covidhospital_ami_exposure["method"] <- "lasso"

lasso_sub_covidhospital_ami_exposure <- lasso_sub_covidhospital_ami_exposure %>%
  dplyr::select(name, method, term, lnhr)


# lasso_X

lasso_X_main_ami_exposure <- lasso_X_main %>%
  dplyr::filter(model == "mdl_max_adj") %>%
  dplyr::filter(term %in% day_terms) %>%
  dplyr::filter(outcome == "ami") %>%
  arrange(sapply(term, function(y) which(y == day_terms)))

lasso_X_main_ami_exposure["method"] <- "lasso_X"

lasso_X_main_ami_exposure <- lasso_X_main_ami_exposure %>%
  dplyr::select(name, method, term, lnhr)

lasso_X_sub_covidhospital_ami_exposure <- lasso_X_sub_covidhospital %>%
  dplyr::filter(model == "mdl_max_adj") %>%
  dplyr::filter(term %in% day_terms) %>%
  dplyr::filter(outcome == "ami") %>%
  arrange(sapply(term, function(y) which(y == day_terms)))

lasso_X_sub_covidhospital_ami_exposure["method"] <- "lasso_X"

lasso_X_sub_covidhospital_ami_exposure <- lasso_X_sub_covidhospital_ami_exposure %>%
  dplyr::select(name, method, term, lnhr)


exposure_coefs_ami_all_models <- rbind(
  fully_adjusted_main_ami_exposure,
  fully_adjusted_sub_covidhospital_ami_exposure,
  lasso_main_ami_exposure,
  lasso_sub_covidhospital_ami_exposure,
  lasso_X_main_ami_exposure,
  lasso_X_sub_covidhospital_ami_exposure
)

print(exposure_coefs_ami_all_models)


# Exposure coefficients stroke_sahhs all models -----------------------------------------
print("Exposure coefficients stroke_sahhs all models")

day_terms <- c(
  "days0_1", "days1_28", "days28_196", "days196_364", "days364_714",
  "days714_1582"
)

# fully_adjusted

fully_adjusted_main_stroke_sahhs_exposure <- fully_adjusted_main %>%
  dplyr::filter(model == "mdl_max_adj") %>%
  dplyr::filter(term %in% day_terms) %>%
  dplyr::filter(outcome == "stroke_sahhs") %>%
  arrange(sapply(term, function(y) which(y == day_terms)))

fully_adjusted_main_stroke_sahhs_exposure["method"] <- "fully_adjusted"

fully_adjusted_main_stroke_sahhs_exposure <- fully_adjusted_main_stroke_sahhs_exposure %>%
  dplyr::select(name, method, term, lnhr)

fully_adjusted_sub_covidhospital_stroke_sahhs_exposure <- fully_adjusted_sub_covidhospital %>%
  dplyr::filter(model == "mdl_max_adj") %>%
  dplyr::filter(term %in% day_terms) %>%
  dplyr::filter(outcome == "stroke_sahhs") %>%
  arrange(sapply(term, function(y) which(y == day_terms)))

fully_adjusted_sub_covidhospital_stroke_sahhs_exposure["method"] <- "fully_adjusted"

fully_adjusted_sub_covidhospital_stroke_sahhs_exposure <- fully_adjusted_sub_covidhospital_stroke_sahhs_exposure %>%
  dplyr::select(name, method, term, lnhr)


# lasso

lasso_main_stroke_sahhs_exposure <- lasso_main %>%
  dplyr::filter(model == "mdl_max_adj") %>%
  dplyr::filter(term %in% day_terms) %>%
  dplyr::filter(outcome == "stroke_sahhs") %>%
  arrange(sapply(term, function(y) which(y == day_terms)))

lasso_main_stroke_sahhs_exposure["method"] <- "lasso"

lasso_main_stroke_sahhs_exposure <- lasso_main_stroke_sahhs_exposure %>%
  dplyr::select(name, method, term, lnhr)

lasso_sub_covidhospital_stroke_sahhs_exposure <- lasso_sub_covidhospital %>%
  dplyr::filter(model == "mdl_max_adj") %>%
  dplyr::filter(term %in% day_terms) %>%
  dplyr::filter(outcome == "stroke_sahhs") %>%
  arrange(sapply(term, function(y) which(y == day_terms)))

lasso_sub_covidhospital_stroke_sahhs_exposure["method"] <- "lasso"

lasso_sub_covidhospital_stroke_sahhs_exposure <- lasso_sub_covidhospital_stroke_sahhs_exposure %>%
  dplyr::select(name, method, term, lnhr)


# lasso_X

lasso_X_main_stroke_sahhs_exposure <- lasso_X_main %>%
  dplyr::filter(model == "mdl_max_adj") %>%
  dplyr::filter(term %in% day_terms) %>%
  dplyr::filter(outcome == "stroke_sahhs") %>%
  arrange(sapply(term, function(y) which(y == day_terms)))

lasso_X_main_stroke_sahhs_exposure["method"] <- "lasso_X"

lasso_X_main_stroke_sahhs_exposure <- lasso_X_main_stroke_sahhs_exposure %>%
  dplyr::select(name, method, term, lnhr)

lasso_X_sub_covidhospital_stroke_sahhs_exposure <- lasso_X_sub_covidhospital %>%
  dplyr::filter(model == "mdl_max_adj") %>%
  dplyr::filter(term %in% day_terms) %>%
  dplyr::filter(outcome == "stroke_sahhs") %>%
  arrange(sapply(term, function(y) which(y == day_terms)))

lasso_X_sub_covidhospital_stroke_sahhs_exposure["method"] <- "lasso_X"

lasso_X_sub_covidhospital_stroke_sahhs_exposure <- lasso_X_sub_covidhospital_stroke_sahhs_exposure %>%
  dplyr::select(name, method, term, lnhr)


exposure_coefs_stroke_sahhs_all_models <- rbind(
  fully_adjusted_main_stroke_sahhs_exposure,
  fully_adjusted_sub_covidhospital_stroke_sahhs_exposure,
  lasso_main_stroke_sahhs_exposure,
  lasso_sub_covidhospital_stroke_sahhs_exposure,
  lasso_X_main_stroke_sahhs_exposure,
  lasso_X_sub_covidhospital_stroke_sahhs_exposure
)

print(exposure_coefs_stroke_sahhs_all_models)


# Save results -----------------------------------------------------------------
print("Save results")

write.csv(
  exposure_coefs_ami_all_models,
  "exposure_coefs_ami_all_models.csv",
  row.names = FALSE
)

write.csv(
  exposure_coefs_stroke_sahhs_all_models,
  "exposure_coefs_stroke_sahhs_all_models.csv",
  row.names = FALSE
)


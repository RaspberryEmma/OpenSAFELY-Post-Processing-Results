#!/bin/bash


# convert CSV's into TeX code
python tably.py "temp/cvd_methods_exposure_coefs_ami_all_models.csv"          -o "outputs/cvd_methods_exposure_coefs_ami_all_models.txt"          -r
python tably.py "temp/cvd_methods_exposure_coefs_stroke_sahhs_all_models.csv" -o "outputs/cvd_methods_exposure_coefs_stroke_sahhs_all_models.txt" -r

python tably.py "temp/cvd_methods_stacked_fully_adjusted_var_sel_models.csv" -o "outputs/cvd_methods_stacked_fully_adjusted_var_sel_models.txt" -r
python tably.py "temp/cvd_methods_stacked_var_sel_models.csv"                -o "outputs/cvd_methods_stacked_var_sel_models.txt" -r
python tably.py "temp/cvd_methods_stacked_variable_sets_ami.csv"             -o "outputs/cvd_methods_stacked_variable_sets_ami.txt" -r
python tably.py "temp/cvd_methods_stacked_variable_sets_stroke_sahhs.csv"    -o "outputs/cvd_methods_stacked_variable_sets_stroke_sahhs.txt" -r

python tably.py "temp/cvd_methods_table1.csv" -o "outputs/cvd_methods_table1.txt" -r
python tably.py "temp/cvd_methods_table2.csv" -o "outputs/cvd_methods_table2.txt" -r

python tably.py "temp/cvd_methods_unc_test_conclusion.csv"                    -o "outputs/cvd_methods_unc_test_conclusion.txt" -r
python tably.py "temp/cvd_methods_unc_test_tests.csv"                         -o "outputs/cvd_methods_unc_test_tests.txt"      -r

python tably.py "temp/cvd_methods_unc_test_regression_ami_fully_adjusted_all.csv" -o "outputs/cvd_methods_unc_test_regression_ami_fully_adjusted_all.txt" -r
python tably.py "temp/cvd_methods_unc_test_regression_ami_lasso_all.csv"          -o "outputs/cvd_methods_unc_test_regression_ami_lasso_all.txt" -r
python tably.py "temp/cvd_methods_unc_test_regression_ami_lasso_X_all.csv"        -o "outputs/cvd_methods_unc_test_regression_ami_lasso_X_all.txt" -r
python tably.py "temp/cvd_methods_unc_test_regression_ami_lasso_union_all.csv"    -o "outputs/cvd_methods_unc_test_regression_ami_lasso_union_all.txt" -r
python tably.py "temp/cvd_methods_unc_test_regression_ami_fully_adjusted_FALSE.csv" -o "outputs/cvd_methods_unc_test_regression_ami_fully_adjusted_FALSE.txt" -r
python tably.py "temp/cvd_methods_unc_test_regression_ami_lasso_FALSE.csv"          -o "outputs/cvd_methods_unc_test_regression_ami_lasso_FALSE.txt" -r
python tably.py "temp/cvd_methods_unc_test_regression_ami_lasso_X_FALSE.csv"        -o "outputs/cvd_methods_unc_test_regression_ami_lasso_X_FALSE.txt" -r
python tably.py "temp/cvd_methods_unc_test_regression_ami_lasso_union_FALSE.csv"    -o "outputs/cvd_methods_unc_test_regression_ami_lasso_union_FALSE.txt" -r
python tably.py "temp/cvd_methods_unc_test_regression_ami_fully_adjusted_TRUE.csv" -o "outputs/cvd_methods_unc_test_regression_ami_fully_adjusted_TRUE.txt" -r
python tably.py "temp/cvd_methods_unc_test_regression_ami_lasso_TRUE.csv"          -o "outputs/cvd_methods_unc_test_regression_ami_lasso_TRUE.txt" -r
python tably.py "temp/cvd_methods_unc_test_regression_ami_lasso_X_TRUE.csv"        -o "outputs/cvd_methods_unc_test_regression_ami_lasso_X_TRUE.txt" -r
python tably.py "temp/cvd_methods_unc_test_regression_ami_lasso_union_TRUE.csv"    -o "outputs/cvd_methods_unc_test_regression_ami_lasso_union_TRUE.txt" -r

python tably.py "temp/cvd_methods_unc_test_regression_stroke_sahhs_fully_adjusted_all.csv" -o "outputs/cvd_methods_unc_test_regression_stroke_sahhs_fully_adjusted_all.txt" -r
python tably.py "temp/cvd_methods_unc_test_regression_stroke_sahhs_lasso_all.csv"          -o "outputs/cvd_methods_unc_test_regression_stroke_sahhs_lasso_all.txt" -r
python tably.py "temp/cvd_methods_unc_test_regression_stroke_sahhs_lasso_X_all.csv"        -o "outputs/cvd_methods_unc_test_regression_stroke_sahhs_lasso_X_all.txt" -r
python tably.py "temp/cvd_methods_unc_test_regression_stroke_sahhs_lasso_union_all.csv"    -o "outputs/cvd_methods_unc_test_regression_stroke_sahhs_lasso_union_all.txt" -r
python tably.py "temp/cvd_methods_unc_test_regression_stroke_sahhs_fully_adjusted_FALSE.csv" -o "outputs/cvd_methods_unc_test_regression_stroke_sahhs_fully_adjusted_FALSE.txt" -r
python tably.py "temp/cvd_methods_unc_test_regression_stroke_sahhs_lasso_FALSE.csv"          -o "outputs/cvd_methods_unc_test_regression_stroke_sahhs_lasso_FALSE.txt" -r
python tably.py "temp/cvd_methods_unc_test_regression_stroke_sahhs_lasso_X_FALSE.csv"        -o "outputs/cvd_methods_unc_test_regression_stroke_sahhs_lasso_X_FALSE.txt" -r
python tably.py "temp/cvd_methods_unc_test_regression_stroke_sahhs_lasso_union_FALSE.csv"    -o "outputs/cvd_methods_unc_test_regression_stroke_sahhs_lasso_union_FALSE.txt" -r
python tably.py "temp/cvd_methods_unc_test_regression_stroke_sahhs_fully_adjusted_TRUE.csv" -o "outputs/cvd_methods_unc_test_regression_stroke_sahhs_fully_adjusted_TRUE.txt" -r
python tably.py "temp/cvd_methods_unc_test_regression_stroke_sahhs_lasso_TRUE.csv"          -o "outputs/cvd_methods_unc_test_regression_stroke_sahhs_lasso_TRUE.txt" -r
python tably.py "temp/cvd_methods_unc_test_regression_stroke_sahhs_lasso_X_TRUE.csv"        -o "outputs/cvd_methods_unc_test_regression_stroke_sahhs_lasso_X_TRUE.txt" -r
python tably.py "temp/cvd_methods_unc_test_regression_stroke_sahhs_lasso_union_TRUE.csv"    -o "outputs/cvd_methods_unc_test_regression_stroke_sahhs_lasso_union_TRUE.txt" -r


# remove first 4 lines (tably header)
sed -i 1,4d "outputs/cvd_methods_exposure_coefs_ami_all_models.txt"
sed -i 1,4d "outputs/cvd_methods_exposure_coefs_stroke_sahhs_all_models.txt"

sed -i 1,4d "outputs/cvd_methods_stacked_fully_adjusted_var_sel_models.txt"
sed -i 1,4d "outputs/cvd_methods_stacked_var_sel_models.txt"
sed -i 1,4d "outputs/cvd_methods_stacked_variable_sets_ami.txt"
sed -i 1,4d "outputs/cvd_methods_stacked_variable_sets_stroke_sahhs.txt"

sed -i 1,4d "outputs/cvd_methods_table1.txt"
sed -i 1,4d "outputs/cvd_methods_table2.txt"

sed -i 1,4d "outputs/cvd_methods_unc_test_conclusion.txt"
sed -i 1,4d "outputs/cvd_methods_unc_test_tests.txt"

sed -i 1,4d "outputs/cvd_methods_unc_test_regression_ami_fully_adjusted_all.txt"
sed -i 1,4d "outputs/cvd_methods_unc_test_regression_ami_lasso_all.txt"
sed -i 1,4d "outputs/cvd_methods_unc_test_regression_ami_lasso_X_all.txt"
sed -i 1,4d "outputs/cvd_methods_unc_test_regression_ami_lasso_union_all.txt"
sed -i 1,4d "outputs/cvd_methods_unc_test_regression_ami_fully_adjusted_FALSE.txt"
sed -i 1,4d "outputs/cvd_methods_unc_test_regression_ami_lasso_FALSE.txt"
sed -i 1,4d "outputs/cvd_methods_unc_test_regression_ami_lasso_X_FALSE.txt"
sed -i 1,4d "outputs/cvd_methods_unc_test_regression_ami_lasso_union_FALSE.txt"
sed -i 1,4d "outputs/cvd_methods_unc_test_regression_ami_fully_adjusted_TRUE.txt"
sed -i 1,4d "outputs/cvd_methods_unc_test_regression_ami_lasso_TRUE.txt"
sed -i 1,4d "outputs/cvd_methods_unc_test_regression_ami_lasso_X_TRUE.txt"
sed -i 1,4d "outputs/cvd_methods_unc_test_regression_ami_lasso_union_TRUE.txt"

sed -i 1,4d "outputs/cvd_methods_unc_test_regression_stroke_sahhs_fully_adjusted_all.txt"
sed -i 1,4d "outputs/cvd_methods_unc_test_regression_stroke_sahhs_lasso_all.txt"
sed -i 1,4d "outputs/cvd_methods_unc_test_regression_stroke_sahhs_lasso_X_all.txt"
sed -i 1,4d "outputs/cvd_methods_unc_test_regression_stroke_sahhs_lasso_union_all.txt"
sed -i 1,4d "outputs/cvd_methods_unc_test_regression_stroke_sahhs_fully_adjusted_FALSE.txt"
sed -i 1,4d "outputs/cvd_methods_unc_test_regression_stroke_sahhs_lasso_FALSE.txt"
sed -i 1,4d "outputs/cvd_methods_unc_test_regression_stroke_sahhs_lasso_X_FALSE.txt"
sed -i 1,4d "outputs/cvd_methods_unc_test_regression_stroke_sahhs_lasso_union_FALSE.txt"
sed -i 1,4d "outputs/cvd_methods_unc_test_regression_stroke_sahhs_fully_adjusted_TRUE.txt"
sed -i 1,4d "outputs/cvd_methods_unc_test_regression_stroke_sahhs_lasso_TRUE.txt"
sed -i 1,4d "outputs/cvd_methods_unc_test_regression_stroke_sahhs_lasso_X_TRUE.txt"
sed -i 1,4d "outputs/cvd_methods_unc_test_regression_stroke_sahhs_lasso_union_TRUE.txt"


# remove last 2 lines (tably footer)
sed -i '$d' "outputs/cvd_methods_exposure_coefs_ami_all_models.txt"
sed -i '$d' "outputs/cvd_methods_exposure_coefs_ami_all_models.txt"
sed -i '$d' "outputs/cvd_methods_exposure_coefs_stroke_sahhs_all_models.txt"
sed -i '$d' "outputs/cvd_methods_exposure_coefs_stroke_sahhs_all_models.txt"

sed -i '$d' "outputs/cvd_methods_stacked_fully_adjusted_var_sel_models.txt"
sed -i '$d' "outputs/cvd_methods_stacked_fully_adjusted_var_sel_models.txt"
sed -i '$d' "outputs/cvd_methods_stacked_var_sel_models.txt"
sed -i '$d' "outputs/cvd_methods_stacked_var_sel_models.txt"
sed -i '$d' "outputs/cvd_methods_stacked_variable_sets_ami.txt"
sed -i '$d' "outputs/cvd_methods_stacked_variable_sets_ami.txt"
sed -i '$d' "outputs/cvd_methods_stacked_variable_sets_stroke_sahhs.txt"
sed -i '$d' "outputs/cvd_methods_stacked_variable_sets_stroke_sahhs.txt"

sed -i '$d' "outputs/cvd_methods_table1.txt"
sed -i '$d' "outputs/cvd_methods_table1.txt"
sed -i '$d' "outputs/cvd_methods_table2.txt"
sed -i '$d' "outputs/cvd_methods_table2.txt"

sed -i '$d' "outputs/cvd_methods_unc_test_conclusion.txt"
sed -i '$d' "outputs/cvd_methods_unc_test_conclusion.txt"
sed -i '$d' "outputs/cvd_methods_unc_test_tests.txt"
sed -i '$d' "outputs/cvd_methods_unc_test_tests.txt"

sed -i '$d' "outputs/cvd_methods_unc_test_regression_ami_fully_adjusted_all.txt"
sed -i '$d' "outputs/cvd_methods_unc_test_regression_ami_fully_adjusted_all.txt"
sed -i '$d' "outputs/cvd_methods_unc_test_regression_ami_lasso_all.txt"
sed -i '$d' "outputs/cvd_methods_unc_test_regression_ami_lasso_all.txt"
sed -i '$d' "outputs/cvd_methods_unc_test_regression_ami_lasso_X_all.txt"
sed -i '$d' "outputs/cvd_methods_unc_test_regression_ami_lasso_X_all.txt"
sed -i '$d' "outputs/cvd_methods_unc_test_regression_ami_lasso_union_all.txt"
sed -i '$d' "outputs/cvd_methods_unc_test_regression_ami_lasso_union_all.txt"
sed -i '$d' "outputs/cvd_methods_unc_test_regression_ami_fully_adjusted_FALSE.txt"
sed -i '$d' "outputs/cvd_methods_unc_test_regression_ami_fully_adjusted_FALSE.txt"
sed -i '$d' "outputs/cvd_methods_unc_test_regression_ami_lasso_FALSE.txt"
sed -i '$d' "outputs/cvd_methods_unc_test_regression_ami_lasso_FALSE.txt"
sed -i '$d' "outputs/cvd_methods_unc_test_regression_ami_lasso_X_FALSE.txt"
sed -i '$d' "outputs/cvd_methods_unc_test_regression_ami_lasso_X_FALSE.txt"
sed -i '$d' "outputs/cvd_methods_unc_test_regression_ami_lasso_union_FALSE.txt"
sed -i '$d' "outputs/cvd_methods_unc_test_regression_ami_lasso_union_FALSE.txt"
sed -i '$d' "outputs/cvd_methods_unc_test_regression_ami_fully_adjusted_TRUE.txt"
sed -i '$d' "outputs/cvd_methods_unc_test_regression_ami_fully_adjusted_TRUE.txt"
sed -i '$d' "outputs/cvd_methods_unc_test_regression_ami_lasso_TRUE.txt"
sed -i '$d' "outputs/cvd_methods_unc_test_regression_ami_lasso_TRUE.txt"
sed -i '$d' "outputs/cvd_methods_unc_test_regression_ami_lasso_X_TRUE.txt"
sed -i '$d' "outputs/cvd_methods_unc_test_regression_ami_lasso_X_TRUE.txt"
sed -i '$d' "outputs/cvd_methods_unc_test_regression_ami_lasso_union_TRUE.txt"
sed -i '$d' "outputs/cvd_methods_unc_test_regression_ami_lasso_union_TRUE.txt"

sed -i '$d' "outputs/cvd_methods_unc_test_regression_stroke_sahhs_fully_adjusted_all.txt"
sed -i '$d' "outputs/cvd_methods_unc_test_regression_stroke_sahhs_fully_adjusted_all.txt"
sed -i '$d' "outputs/cvd_methods_unc_test_regression_stroke_sahhs_lasso_all.txt"
sed -i '$d' "outputs/cvd_methods_unc_test_regression_stroke_sahhs_lasso_all.txt"
sed -i '$d' "outputs/cvd_methods_unc_test_regression_stroke_sahhs_lasso_X_all.txt"
sed -i '$d' "outputs/cvd_methods_unc_test_regression_stroke_sahhs_lasso_X_all.txt"
sed -i '$d' "outputs/cvd_methods_unc_test_regression_stroke_sahhs_lasso_union_all.txt"
sed -i '$d' "outputs/cvd_methods_unc_test_regression_stroke_sahhs_lasso_union_all.txt"
sed -i '$d' "outputs/cvd_methods_unc_test_regression_stroke_sahhs_fully_adjusted_FALSE.txt"
sed -i '$d' "outputs/cvd_methods_unc_test_regression_stroke_sahhs_fully_adjusted_FALSE.txt"
sed -i '$d' "outputs/cvd_methods_unc_test_regression_stroke_sahhs_lasso_FALSE.txt"
sed -i '$d' "outputs/cvd_methods_unc_test_regression_stroke_sahhs_lasso_FALSE.txt"
sed -i '$d' "outputs/cvd_methods_unc_test_regression_stroke_sahhs_lasso_X_FALSE.txt"
sed -i '$d' "outputs/cvd_methods_unc_test_regression_stroke_sahhs_lasso_X_FALSE.txt"
sed -i '$d' "outputs/cvd_methods_unc_test_regression_stroke_sahhs_lasso_union_FALSE.txt"
sed -i '$d' "outputs/cvd_methods_unc_test_regression_stroke_sahhs_lasso_union_FALSE.txt"
sed -i '$d' "outputs/cvd_methods_unc_test_regression_stroke_sahhs_fully_adjusted_TRUE.txt"
sed -i '$d' "outputs/cvd_methods_unc_test_regression_stroke_sahhs_fully_adjusted_TRUE.txt"
sed -i '$d' "outputs/cvd_methods_unc_test_regression_stroke_sahhs_lasso_TRUE.txt"
sed -i '$d' "outputs/cvd_methods_unc_test_regression_stroke_sahhs_lasso_TRUE.txt"
sed -i '$d' "outputs/cvd_methods_unc_test_regression_stroke_sahhs_lasso_X_TRUE.txt"
sed -i '$d' "outputs/cvd_methods_unc_test_regression_stroke_sahhs_lasso_X_TRUE.txt"
sed -i '$d' "outputs/cvd_methods_unc_test_regression_stroke_sahhs_lasso_union_TRUE.txt"
sed -i '$d' "outputs/cvd_methods_unc_test_regression_stroke_sahhs_lasso_union_TRUE.txt"

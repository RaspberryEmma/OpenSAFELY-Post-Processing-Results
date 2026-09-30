#!/bin/bash


# convert CSV's into TeX code
python tably.py "temp/cvd_methods_exposure_coefs_ami_all_models.csv"          -o "outputs/cvd_methods_exposure_coefs_ami_all_models.txt"          -r
python tably.py "temp/cvd_methods_exposure_coefs_stroke_sahhs_all_models.csv" -o "outputs/cvd_methods_exposure_coefs_stroke_sahhs_all_models.txt" -r

python tably.py "temp/cvd_methods_stacked_fully_adjusted_var_sel_models.csv" -o "outputs/cvd_methods_stacked_fully_adjusted_var_sel_models.txt" -r
python tably.py "temp/cvd_methods_stacked_var_sel_models.csv" -o "outputs/cvd_methods_stacked_var_sel_models.txt" -r
python tably.py "temp/cvd_methods_stacked_variable_sets.csv" -o "outputs/cvd_methods_stacked_variable_sets.txt" -r

python tably.py "temp/cvd_methods_table1.csv" -o "outputs/cvd_methods_table1.txt" -r
python tably.py "temp/cvd_methods_table2.csv" -o "outputs/cvd_methods_table2.txt" -r

python tably.py "temp/cvd_methods_unc_test_conclusion.csv" -o "outputs/cvd_methods_unc_test_conclusion.txt" -r
python tably.py "temp/cvd_methods_unc_test_regression.csv" -o "outputs/cvd_methods_unc_test_regression.txt" -r
python tably.py "temp/cvd_methods_unc_test_tests.csv"      -o "outputs/cvd_methods_unc_test_tests.txt"      -r


# remove first 4 lines (tably header)
sed -i 1,4d "outputs/cvd_methods_exposure_coefs_ami_all_models.txt"
sed -i 1,4d "outputs/cvd_methods_exposure_coefs_stroke_sahhs_all_models.txt"

sed -i 1,4d "outputs/cvd_methods_stacked_fully_adjusted_var_sel_models.txt"
sed -i 1,4d "outputs/cvd_methods_stacked_var_sel_models.txt"
sed -i 1,4d "outputs/cvd_methods_stacked_variable_sets.txt"

sed -i 1,4d "outputs/cvd_methods_table1.txt"
sed -i 1,4d "outputs/cvd_methods_table2.txt"

sed -i 1,4d "outputs/cvd_methods_unc_test_conclusion.txt"
sed -i 1,4d "outputs/cvd_methods_unc_test_regression.txt"
sed -i 1,4d "outputs/cvd_methods_unc_test_tests.txt"


# # remove last 2 lines (tably footer)
sed -i '$d' "outputs/cvd_methods_exposure_coefs_ami_all_models.txt"
sed -i '$d' "outputs/cvd_methods_exposure_coefs_ami_all_models.txt"
sed -i '$d' "outputs/cvd_methods_exposure_coefs_stroke_sahhs_all_models.txt"
sed -i '$d' "outputs/cvd_methods_exposure_coefs_stroke_sahhs_all_models.txt"

sed -i '$d' "outputs/cvd_methods_stacked_fully_adjusted_var_sel_models.txt"
sed -i '$d' "outputs/cvd_methods_stacked_fully_adjusted_var_sel_models.txt"
sed -i '$d' "outputs/cvd_methods_stacked_var_sel_models.txt"
sed -i '$d' "outputs/cvd_methods_stacked_var_sel_models.txt"
sed -i '$d' "outputs/cvd_methods_stacked_variable_sets.txt"
sed -i '$d' "outputs/cvd_methods_stacked_variable_sets.txt"

sed -i '$d' "outputs/cvd_methods_table1.txt"
sed -i '$d' "outputs/cvd_methods_table1.txt"
sed -i '$d' "outputs/cvd_methods_table2.txt"
sed -i '$d' "outputs/cvd_methods_table2.txt"

sed -i '$d' "outputs/cvd_methods_unc_test_conclusion.txt"
sed -i '$d' "outputs/cvd_methods_unc_test_conclusion.txt"
sed -i '$d' "outputs/cvd_methods_unc_test_regression.txt"
sed -i '$d' "outputs/cvd_methods_unc_test_regression.txt"
sed -i '$d' "outputs/cvd_methods_unc_test_tests.txt"
sed -i '$d' "outputs/cvd_methods_unc_test_tests.txt"

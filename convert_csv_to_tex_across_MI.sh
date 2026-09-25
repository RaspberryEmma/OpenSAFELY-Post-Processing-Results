#!/bin/bash

# convert CSV's into TeX code
python tably.py "temp/cvd_missingness_methods_across_MI_all_aggregate_var_selection.csv" -o "outputs/cvd_missingness_methods_across_MI_all_aggregate_var_selection.txt" -r
python tably.py "temp/cvd_missingness_methods_across_MI_all_mean_var_selection.csv"      -o "outputs/cvd_missingness_methods_across_MI_all_mean_var_selection.txt"      -r
python tably.py "temp/cvd_missingness_methods_across_MI_all_cox.csv"                     -o "outputs/cvd_missingness_methods_across_MI_all_cox.txt"                     -r
python tably.py "temp/cvd_missingness_methods_across_MI_unc_test_conclusion.csv"         -o "outputs/cvd_missingness_methods_across_MI_unc_test_conclusion.txt"         -r
python tably.py "temp/cvd_missingness_methods_across_MI_unc_test_regression.csv"         -o "outputs/cvd_missingness_methods_across_MI_unc_test_regression.txt"         -r
python tably.py "temp/cvd_missingness_methods_across_MI_unc_test_tests.csv"              -o "outputs/cvd_missingness_methods_across_MI_unc_test_tests.txt"              -r

# remove first 4 lines (tably header)
sed -i 1,4d "outputs/cvd_missingness_methods_across_MI_all_aggregate_var_selection.txt"
sed -i 1,4d "outputs/cvd_missingness_methods_across_MI_all_mean_var_selection.txt"
sed -i 1,4d "outputs/cvd_missingness_methods_across_MI_all_cox.txt"
sed -i 1,4d "outputs/cvd_missingness_methods_across_MI_unc_test_conclusion.txt"
sed -i 1,4d "outputs/cvd_missingness_methods_across_MI_unc_test_regression.txt"
sed -i 1,4d "outputs/cvd_missingness_methods_across_MI_unc_test_tests.txt"

# # remove last 2 lines (tably footer)
sed -i '$d' "outputs/cvd_missingness_methods_across_MI_all_aggregate_var_selection.txt"
sed -i '$d' "outputs/cvd_missingness_methods_across_MI_all_aggregate_var_selection.txt"
sed -i '$d' "outputs/cvd_missingness_methods_across_MI_all_mean_var_selection.txt"
sed -i '$d' "outputs/cvd_missingness_methods_across_MI_all_mean_var_selection.txt"
sed -i '$d' "outputs/cvd_missingness_methods_across_MI_all_cox.txt"
sed -i '$d' "outputs/cvd_missingness_methods_across_MI_all_cox.txt"
sed -i '$d' "outputs/cvd_missingness_methods_across_MI_unc_test_conclusion.txt"
sed -i '$d' "outputs/cvd_missingness_methods_across_MI_unc_test_conclusion.txt"
sed -i '$d' "outputs/cvd_missingness_methods_across_MI_unc_test_regression.txt"
sed -i '$d' "outputs/cvd_missingness_methods_across_MI_unc_test_regression.txt"
sed -i '$d' "outputs/cvd_missingness_methods_across_MI_unc_test_tests.txt"
sed -i '$d' "outputs/cvd_missingness_methods_across_MI_unc_test_tests.txt"

#!/bin/bash

# convert CSV's into TeX code
python tably.py "temp/cvd_methods_exposure_coefs_ami_all_models.csv"          -o "outputs/cvd_methods_exposure_coefs_ami_all_models.txt"          -r
python tably.py "temp/cvd_methods_exposure_coefs_stroke_sahhs_all_models.csv" -o "outputs/cvd_methods_exposure_coefs_stroke_sahhs_all_models.txt" -r

# remove first 4 lines (tably header)
sed -i 1,4d "outputs/cvd_methods_exposure_coefs_ami_all_models.txt"
sed -i 1,4d "outputs/cvd_methods_exposure_coefs_stroke_sahhs_all_models.txt"


# # remove last 2 lines (tably footer)
sed -i '$d' "outputs/cvd_methods_exposure_coefs_ami_all_models.txt"
sed -i '$d' "outputs/cvd_methods_exposure_coefs_ami_all_models.txt"

sed -i '$d' "outputs/cvd_methods_exposure_coefs_stroke_sahhs_all_models.txt"
sed -i '$d' "outputs/cvd_methods_exposure_coefs_stroke_sahhs_all_models.txt"

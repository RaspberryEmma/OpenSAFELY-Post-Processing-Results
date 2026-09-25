#!/bin/bash

# convert CSV's into TeX code
python tably.py "temp/<NAME>.csv"  -o "outputs/<NAME>.txt"  -r

# remove first 4 lines (tably header)
sed -i 1,4d "outputs/<NAME>.txt"

# # remove last 2 lines (tably footer)
sed -i '$d' "outputs/<NAME>.txt"
sed -i '$d' "outputs/<NAME>.txt"

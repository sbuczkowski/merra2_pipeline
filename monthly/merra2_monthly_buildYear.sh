#!/bin/bash

# Call merra2_monthly_buildMonth for each month in
# specified year

# usage:  merra2_monthly_buildYear YYYY

BIN=.

YEAR=$1 

echo "* Retrieving MERRA2 for year $year"
for MONTH in $(seq -w 1 12); do

    echo -e "-> Calling merra2_monthly_buildMonth for $year/$month\n"
    $BIN/merra2_monthly_buildMonth.sh $YEAR $MONTH

done

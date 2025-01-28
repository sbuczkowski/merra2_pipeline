#!/bin/bash

# Call merra2_build_monthly for each month in
# specified year

# usage:  merra2_build_monthly_year YYYY

BIN=/home/sbuczko1/git/merra2_pipeline/monthly

year=$1 

echo "* Retrieving MERRA2 for year $year"
for month in $(seq -w 1 12); do

    echo "** Calling build_monthly for $year/$month"
    $BIN/merra2_build_monthly.sh $year $month

done

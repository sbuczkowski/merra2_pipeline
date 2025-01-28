#!/bin/bash

# Call get_merra_monthly, repackage_merra_monthly, and
# move_merra_monthly for specified year and month

# usage:  get_merra_monthly_year YYYY
BIN=/home/sbuczko1/git/merra2_pipeline/monthly

year=$1 
month=$2

# call get_merra_monthly to pull down MERRA2 files for the month
echo "> Retrieving monthly MERRA2 files for $year/$month"
$BIN/get_merra2_monthly.sh $year $month

# call repackage_merra_monthly to get things into final format
echo "> Repackaging ASL desired variables"
$BIN/repackage_merra2_monthly.sh $year $month

# call move_merra_monthly to put resulting files into working directories
echo "> Moving compressed output files to archive tree"
$BIN/move_merra2_monthly.sh $year $month

# call cleanup routine to remove source nc4 files
echo "> Cleaning up primary and intermediate netcdf files"
$BIN/clean_merra2_monthly.sh $year $month


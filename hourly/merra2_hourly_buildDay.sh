#!/bin/bash

# Call get, repackage, move, and
# clea scripts for specified year and month

# usage: merra2_hourly_buildDay.sh YYYY MM DD
BIN=.

YEAR=$1 
MONTH=$2
DAY=$3

echo "** Retrieving MERRA2 for $YEAR/$MONTH/$DAY"
# call get_merra_hourly to pull down MERRA2 files for the month
echo -e "--> Retrieving required MERRA2 hourly files\n"
$BIN/merra2_hourly_getDay.sh $YEAR $MONTH $DAY

# call repackage_merra_hourly to get things into final format
echo -e "--> Repackaging ASL desired variables\n"
$BIN/merra2_hourly_repackDay.sh $YEAR $MONTH $DAY

# call move_merra_hourly to put resulting files into working directories
echo -e "--> Moving compressed output files to archive tree\n"
$BIN/move_merra2_hourly.sh $YEAR $MONTH $DAY

# call cleanup routine to remove source nc4 files
echo -e "--> Cleaning up primary and intermediate netcdf files\n"
$BIN/clean_merra2_hourly.sh 


#!/bin/bash

# Call get, repackage, move, and
# clea scripts for specified year and month

# usage: merra2_monthly_buildMonth.sh YYYY MM
BIN=.

YEAR=$1 
MONTH=$2

echo "** Retrieving MERRA2 for $YEAR/$MONTH"
# call get_merra_monthly to pull down MERRA2 files for the month
#echo -e "--> Retrieving required MERRA2 monthly files\n"
$BIN/merra2_monthly_getMonth.sh $YEAR $MONTH 

# call repackage_merra_monthly to get things into final format
#echo -e "--> Repackaging ASL desired variables\n"
$BIN/merra2_monthly_repackMonth.sh $YEAR $MONTH 

# call move_merra_monthly to put resulting files into working directories
#echo -e "--> Moving compressed output files to archive tree\n"
$BIN/move_merra2_monthly.sh $YEAR $MONTH 

# call cleanup routine to remove source nc4 files
#echo -e "--> Cleaning up primary and intermediate netcdf files\n"
$BIN/clean_merra2_monthly.sh 


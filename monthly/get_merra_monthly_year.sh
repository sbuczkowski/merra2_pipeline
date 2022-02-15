#!/bin/bash

# Call get_merra_monthly, repackage_merra_monthly, and move_merra_monthly for each month of
# specified year

# usage:  get_merra_monthly_year YYYY

year=$1 

for month in $(seq -w 1 12); do

    # call get_merra_monthly to pull down MERRA2 files for the day
    get_merra_monthly $year $month

    # call repackage_merra_monthly to get things into final format
    repackage_merra_monthly $year $month

    # call move_merra_monthly to put resulting files into working directories
    move_merra_monthly $year $month

done

#!/bin/bash

# Call get_merra, repackage_merra, and move_merra for each day of
# specified year

# usage:  get_merra_year YYYY

year=$1 

# find number of days in year and loop over them
NDAYS=$(date -d "${year}-01-01 + 1 year - 1 day" +"%j")

declare -a tarray
for doy in $(seq 1 $NDAYS); do
    tarray=($(date -d "$year-01-01 - 1 day + $doy days" +"%Y %m %d"))

    # call get_merra to pull down MERRA2 files for the day
    get_merra ${tarray[0]} ${tarray[1]} ${tarray[2]}

    # call repackage_merra to get things into final format
    repackage_merra ${tarray[0]} ${tarray[1]} ${tarray[2]}

    # call move_merra to put resulting files into working directories
    move_merra ${tarray[0]} ${tarray[1]} ${tarray[2]}

    # call clean_merra to reset INCOMING space for next download
    clean_merra ${tarray[0]} ${tarray[1]} ${tarray[2]}
done

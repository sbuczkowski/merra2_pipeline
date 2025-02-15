#!/bin/bash

BIN=.

YEAR=$1

# find number of days in year and loop over them
NDAYS=$(date -d "${YEAR}-01-01 + 1 year - 1 day" +"%j")

declare -a tarray
for doy in $(seq 1 $NDAYS); do
    tarray=($(date -d "$YEAR-01-01 - 1 day + $doy days" +"%Y %m %d"))

    # call merra2_hourly_buildDay to pull down MERRA2 files for the day
    $BIN/merra2_hourly_buildDay.sh  ${tarray[0]} ${tarray[1]} ${tarray[2]}

done


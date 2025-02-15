#!/bin/bash

BIN=.

YEAR=$1
MONTH=$2

# find number of days in month and loop over them
NDAYS=$(date -d "${YEAR}-${MONTH}-01 + 1 month - 1 day" +"%d")

declare -a tarray
for dom in $(seq 1 $NDAYS); do
    tarray=($(date -d "$YEAR-$MONTH-01 - 1 day + $dom days" +"%Y %m %d"))

    # call merra2_hourly_buildDay to pull down MERRA2 files for the day
    $BIN/merra2_hourly_buildDay.sh  ${tarray[0]} ${tarray[1]} ${tarray[2]}

done


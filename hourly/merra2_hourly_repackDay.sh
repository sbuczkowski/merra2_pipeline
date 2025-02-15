#!/bin/bash

BIN=.

YEAR=$1
MONTH=$2
DAY=$3

echo -e "\n*** Repackaging variables for ${YEAR}/${MONTH}/${DAY}"
echo "---> pressure level variables" 
$BIN/repackage_merra2_hourly_levels.sh $YEAR $MONTH $DAY
echo "---> surface variables" 
$BIN/repackage_merra2_hourly_surface.sh $YEAR $MONTH $DAY


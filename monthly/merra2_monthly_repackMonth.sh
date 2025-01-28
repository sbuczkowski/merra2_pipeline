#!/bin/bash

BIN=.

YEAR=$1
MONTH=$2

echo -e "\n*** Repackaging variables for ${YEAR}/${MONTH}"
echo "---> pressure level variables" 
$BIN/repackage_merra2_monthly_levels.sh $YEAR $MONTH 
echo "---> surface variables" 
$BIN/repackage_merra2_monthly_surface.sh $YEAR $MONTH


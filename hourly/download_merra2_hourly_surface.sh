#!/bin/bash

# Grabs one day of MERRA hourly surface files necessary to collect
# all ERA-like variables for repackaging
#
# Usage:  download_merra2_hourly_surface.sh <YYYY> <MM> <DD>
#
# Script tries to download intermediate files to a common INCOMING
# directory. Repackage, move, and clean scripts will look there
# for files to operate on.
BIN=.

YEAR=$1
MONTH=$2
DAY=$3

echo -e "\n**** Downloading surface level files"
echo -e "----> surface asm file" 
$BIN/merra2_hourly_downloadFile.sh -S asm $YEAR $MONTH $DAY
echo -e "----> surface rad file"
$BIN/merra2_hourly_downloadFile.sh -S rad $YEAR $MONTH $DAY
echo -e "----> surface flx file"
$BIN/merra2_hourly_downloadFile.sh -S flx $YEAR $MONTH $DAY




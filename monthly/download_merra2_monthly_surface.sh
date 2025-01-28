#!/bin/bash

# Grabs one month of MERRA monthly surface files necessary to collect
# all ERA-like variables for repackaging
#
# Usage:  download_merra2_monthly_surface.sh <YYYY> <MM>
#
# Script tries to download intermediate files to a common INCOMING
# directory. Repackage, move, and clean scripts will look there
# for files to operate on.
BIN=.

YEAR=$1
MONTH=$2

echo -e "\n**** Downloading surface level files"
echo -e "----> surface asm file" 
$BIN/merra2_monthly_downloadFile.sh -S asm $YEAR $MONTH
echo -e "----> surface rad file"
$BIN/merra2_monthly_downloadFile.sh -S rad $YEAR $MONTH
echo -e "----> surface flx file"
$BIN/merra2_monthly_downloadFile.sh -S flx $YEAR $MONTH




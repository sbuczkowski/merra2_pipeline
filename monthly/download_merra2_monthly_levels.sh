#!/bin/bash

# Grabs one month of MERRA monthly pressure levels files necessary to
# collect all ERA-like variables for repackaging
#
# Usage: download_merra2_monthly_levels.sh <YYYY> <MM>
#
# Script tries to download intermediate files to a common INCOMING
# directory. Repackage, move, and clean scripts will look there
# for files to operate on.
BIN=.

YEAR=$1
MONTH=$2

echo -e "\n**** Downloading pressure level files"
echo -e "----> levels asm file"
$BIN/merra2_monthly_downloadFile.sh -L asm $YEAR $MONTH
echo -e "----> levels cld file"
$BIN/merra2_monthly_downloadFile.sh -L cld $YEAR $MONTH




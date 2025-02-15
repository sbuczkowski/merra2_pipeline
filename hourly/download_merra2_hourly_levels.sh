#!/bin/bash

# Grabs one day of MERRA hourly pressure levels files necessary to
# collect all ERA-like variables for repackaging
#
# Usage: download_merra2_hourly_levels.sh <YYYY> <MM> <DD>
#
# Script tries to download intermediate files to a common INCOMING
# directory. Repackage, move, and clean scripts will look there
# for files to operate on.
BIN=.

YEAR=$1
MONTH=$2
DAY=$3

echo -e "\n**** Downloading pressure level files"
echo -e "----> levels asm file"
$BIN/merra2_hourly_downloadFile.sh -L asm $YEAR $MONTH $DAY
echo -e "----> levels cld file"
$BIN/merra2_hourly_downloadFile.sh -L chm $YEAR $MONTH $DAY
echo -e "----> levels aer file"
$BIN/merra2_hourly_downloadFile.sh -L aer $YEAR $MONTH $DAY




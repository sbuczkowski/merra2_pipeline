#!/bin/bash

BIN=.

YEAR=$1
MONTH=$2

echo -e "\n*** Grabbing levels files for ${YEAR}/${MONTH}"
$BIN/download_merra2_monthly_levels.sh $YEAR $MONTH 

echo -e "\n*** Grabbing surface files for ${YEAR}/${MONTH}"
$BIN/download_merra2_monthly_surface.sh $YEAR $MONTH


#!/bin/bash

BIN=.

YEAR=$1
MONTH=$2
DAY=$3

echo -e "\n*** Grabbing levels files for ${YEAR}/${MONTH}/${DAY}"
$BIN/download_merra2_hourly_levels.sh $YEAR $MONTH $DAY

echo -e "\n*** Grabbing surface files for ${YEAR}/${MONTH}/${DAY}"
$BIN/download_merra2_hourly_surface.sh $YEAR $MONTH $DAY


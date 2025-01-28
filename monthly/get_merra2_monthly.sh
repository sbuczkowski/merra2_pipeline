#!/bin/bash

BIN=/home/sbuczko1/git/merra2_pipeline/monthly

year=$1
month=$2

echo ">> Retrieve monthly level files for $year/$month"
$BIN/get_merra2_levels_monthly.sh $year $month

echo ">> Retrieve monthly surface files for $year/$month"
$BIN/get_merra2_surface_monthly.sh $year $month


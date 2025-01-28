#!/bin/bash

BIN=/home/sbuczko1/git/merra2_pipeline/monthly

year=$1
month=$2

$BIN/repackage_merra2_levels_monthly.sh $year $month

$BIN/repackage_merra2_surface_monthly.sh $year $month


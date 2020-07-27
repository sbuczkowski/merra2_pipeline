#!/bin/bash

# Grabs one day of MERRA files necessary to collect all ERA-like
# variables for repackaging
#
# Usage: getmerra <YYYY> <MM> <DD>
#
# Script tries to download intermediate files to a common INCOMING
# directory. Scripts repackage_merra and move_merra will look there
# for files to operate on.

year=$1
month=$2
day=$3

BASEDIR="/umbc/isilon/rs/strow/asl/merra2/incoming"
if [[ ! -d $BASEDIR ]]; then
    mkdir -p $BASEDIR
fi

SURFURL="https://goldsmr4.gesdisc.eosdis.nasa.gov/data/MERRA2/"
LEVURL="https://goldsmr5.gesdisc.eosdis.nasa.gov/data/MERRA2/"

# Filenames have differing versions before/after blocks of years. Need
# to select correct one based upon input year (VERS also goes down to
# 200 in years prior to 2002 but, we are concerned with AIRS lifespan
# at most for now). Have to watch out for when version jumps to 500
# (no a priori idea when this might happen or how we will find out;
# other than script failure)
if [ $year -lt 2011 ]; then
    VERS=300
else
    VERS=400
fi

# At the time this script is being written, there is no overall
# ability to query the MERRA dataset(s) and just pull what we need on
# common grids. Spatial grid is common across datasets but temporal is
# not with "instantaneous" datasets registering on the hour and
# "averaged" datasets registering on the half hour. In order to get
# all of the variables we use for rtp production, we have to pull from
# both sets resulting in 30 minute offsets between
# variables. Hopefully, this does not become an issue. If it does,
# solution will likely require getting NASA Goddard to repackage
# MERRA2 and develop a more flexible query system.
echo "Grabbing surface asm file for ${year}/${month}/${day}"
wget --directory-prefix=$BASEDIR ${SURFURL}/M2I1NXASM.5.12.4/${year}/${month}/MERRA2_${VERS}.inst1_2d_asm_Nx.${year}${month}${day}.nc4
echo "Grabbing surface rad file for ${year}/${month}/${day}"
wget --directory-prefix=$BASEDIR ${SURFURL}/M2T1NXRAD.5.12.4/${year}/${month}/MERRA2_${VERS}.tavg1_2d_rad_Nx.${year}${month}${day}.nc4
echo "Grabbing surface flx file for ${year}/${month}/${day}"
wget --directory-prefix=$BASEDIR ${SURFURL}/M2T1NXFLX.5.12.4/${year}/${month}/MERRA2_${VERS}.tavg1_2d_flx_Nx.${year}${month}${day}.nc4
echo "Grabbing levels asm file for ${year}/${month}/${day}"
wget --directory-prefix=$BASEDIR ${LEVURL}/M2I3NVASM.5.12.4/${year}/${month}/MERRA2_${VERS}.inst3_3d_asm_Nv.${year}${month}${day}.nc4

echo "Grabbing levels aer (SO2) file for ${year}/${month}/${day}"
wget --directory-prefix=$BASEDIR ${LEVURL}/M2I3NVAER.5.12.4/${year}/${month}/MERRA2_${VERS}.inst3_3d_aer_Nv.${year}${month}${day}.nc4
echo "Grabbing levels chm (CO) file for ${year}/${month}/${day}"
wget --directory-prefix=$BASEDIR ${LEVURL}/M2I3NVCHM.5.12.4/${year}/${month}/MERRA2_${VERS}.inst3_3d_chm_Nv.${year}${month}${day}.nc4



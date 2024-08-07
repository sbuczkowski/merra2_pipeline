#!/bin/bash

# Grabs one day of MERRA files necessary to collect all ERA-like
# variables for repackaging
#
# Usage: get_merra_monthly <YYYY> <MM>
#
# Script tries to download intermediate files to a common INCOMING
# directory. Scripts repackage_merra and move_merra will look there
# for files to operate on.

year=$1
month=$2
VERS=$3

# BASEDIR="/umbc/isilon/rs/strow/asl/merra2/incoming"
BASEDIR="/umbc/xfs3/strow/asl/merra2_monthly/INCOMING"
if [[ ! -d $BASEDIR ]]; then
    mkdir -p $BASEDIR
fi

SURFURL="https://goldsmr4.gesdisc.eosdis.nasa.gov/data/MERRA2_MONTHLY/"
LEVURL="https://goldsmr5.gesdisc.eosdis.nasa.gov/data/MERRA2_MONTHLY/"

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
BOILERPLATE="-nv --load-cookies ${HOME}/.urs_cookies --save-cookies ${HOME}/.urs_cookies --auth-no-challenge=on --keep-session-cookies"

echo -e "\n** Grabbing surface files for ${year}/${month}/${day} **\n"
echo "--> surface asm file" 
wget $BOILERPLATE --directory-prefix=$BASEDIR ${SURFURL}/M2IMNXASM.5.12.4/${year}/MERRA2_${VERS}.instM_2d_asm_Nx.${year}${month}.nc4
echo "--> surface rad file"
wget $BOILERPLATE --directory-prefix=$BASEDIR ${SURFURL}/M2TMNXRAD.5.12.4/${year}/MERRA2_${VERS}.tavgM_2d_rad_Nx.${year}${month}.nc4
echo "--> surface flx file"
wget $BOILERPLATE --directory-prefix=$BASEDIR ${SURFURL}/M2TMNXFLX.5.12.4/${year}/MERRA2_${VERS}.tavgM_2d_flx_Nx.${year}${month}.nc4

echo -e "\n** Grabbing levels files for ${year}/${month}/${day} **\n"
echo "--> levels asm file"
wget $BOILERPLATE --directory-prefix=$BASEDIR ${LEVURL}/M2IMNPASM.5.12.4/${year}/MERRA2_${VERS}.instM_3d_asm_Np.${year}${month}.nc4
echo "--> levels cld file"
wget $BOILERPLATE --directory-prefix=$BASEDIR ${LEVURL}/M2TMNPCLD.5.12.4/${year}/MERRA2_${VERS}.tavgM_3d_cld_Np.${year}${month}.nc4



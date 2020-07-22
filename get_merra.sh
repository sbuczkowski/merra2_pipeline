#!/bin/bash

# Grabs one day of MERRA files necessary to collect all ERA-like
# variables for repackaging
#
# Usage: getmerra <YYYY> <MM> <DD>
#
# Caveat: Present version stores downloaded files in the current directory

year=$1
month=$2
day=$3

SURFURL="https://goldsmr4.gesdisc.eosdis.nasa.gov/data/MERRA2/"
LEVURL="https://goldsmr5.gesdisc.eosdis.nasa.gov/data/MERRA2/"

# Filenames have differing versions before/after blocks of years. Need
# to select correct one based upon input year (VERS also goes down to
# 200 in years prior to 2002 but, we are concerned with AIRS lifespan
# at most for now)
if [ $year -lt 2011 ]; then
    VERS=300
else
    VERS=400
fi

echo "Grabbing surface asm file for ${year}/${month}/${day}"
wget ${SURFURL}/M2I1NXASM.5.12.4/${year}/${month}/MERRA2_${VERS}.inst1_2d_asm_Nx.${year}${month}${day}.nc4
echo "Grabbing surface rad file for ${year}/${month}/${day}"
wget ${SURFURL}/M2T1NXRAD.5.12.4/${year}/${month}/MERRA2_${VERS}.tavg1_2d_rad_Nx.${year}${month}${day}.nc4
echo "Grabbing surface flx file for ${year}/${month}/${day}"
wget ${SURFURL}/M2T1NXFLX.5.12.4/${year}/${month}/MERRA2_${VERS}.tavg1_2d_flx_Nx.${year}${month}${day}.nc4
echo "Grabbing levels asm file for ${year}/${month}/${day}"
wget ${LEVURL}/M2I3NVASM.5.12.4/${year}/${month}/MERRA2_${VERS}.inst3_3d_asm_Nv.${year}${month}${day}.nc4

echo "Grabbing levels aer (SO2) file for ${year}/${month}/${day}"
wget ${LEVURL}/M2I3NVAER.5.12.4/${year}/${month}/MERRA2_${VERS}.inst3_3d_aer_Nv.${year}${month}${day}.nc4
echo "Grabbing levels chm (CO) file for ${year}/${month}/${day}"
wget ${LEVURL}/M2I3NVCHM.5.12.4/${year}/${month}/MERRA2_${VERS}.inst3_3d_chm_Nv.${year}${month}${day}.nc4



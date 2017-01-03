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

# echo "Grabbing surface asm file for ${year}/${month}/${day}"
# wget http://goldsmr4.sci.gsfc.nasa.gov/opendap/MERRA2/M2I1NXASM.5.12.4/${year}/${month}/MERRA2_400.inst1_2d_asm_Nx.${year}${month}${day}.nc4
# echo "Grabbing surface rad file for ${year}/${month}/${day}"
# wget http://goldsmr4.sci.gsfc.nasa.gov/opendap/MERRA2/M2T1NXRAD.5.12.4/${year}/${month}/MERRA2_400.tavg1_2d_rad_Nx.${year}${month}${day}.nc4
# echo "Grabbing surface flx file for ${year}/${month}/${day}"
# wget http://goldsmr4.sci.gsfc.nasa.gov/opendap/MERRA2/M2T1NXFLX.5.12.4/${year}/${month}/MERRA2_400.tavg1_2d_flx_Nx.${year}${month}${day}.nc4
# echo "Grabbing levels asm file for ${year}/${month}/${day}"
# wget http://goldsmr5.sci.gsfc.nasa.gov/opendap/MERRA2/M2I3NVASM.5.12.4/${year}/${month}/MERRA2_400.inst3_3d_asm_Nv.${year}${month}${day}.nc4
#
echo "Grabbing levels aer (SO2) file for ${year}/${month}/${day}"
wget --no-check-certificate http://goldsmr5.sci.gsfc.nasa.gov/opendap/MERRA2/M2I3NVAER.5.12.4/${year}/${month}/MERRA2_400.inst3_3d_aer_Nv.${year}${month}${day}.nc4
echo "Grabbing levels chm (CO) file for ${year}/${month}/${day}"
wget --no-check-certificate http://goldsmr5.sci.gsfc.nasa.gov/opendap/MERRA2/M2I3NVCHM.5.12.4/${year}/${month}/MERRA2_400.inst3_3d_chm_Nv.${year}${month}${day}.nc4



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

echo "Grabbing surface slv file for ${year}/${month}/${day}"
wget http://goldsmr4.sci.gsfc.nasa.gov/opendap/MERRA2/M2T1NXSLV.5.12.4/${year}/${month}/MERRA2_400.tavg1_2d_slv_Nx.${year}${month}${day}.nc4
echo "Grabbing surface rad file for ${year}/${month}/${day}"
wget http://goldsmr4.sci.gsfc.nasa.gov/opendap/MERRA2/M2T1NXRAD.5.12.4/${year}/${month}/MERRA2_400.tavg1_2d_rad_Nx.${year}${month}${day}.nc4
echo "Grabbing surface flx file for ${year}/${month}/${day}"
wget http://goldsmr4.sci.gsfc.nasa.gov/opendap/MERRA2/M2T1NXFLX.5.12.4/${year}/${month}/MERRA2_400.tavg1_2d_flx_Nx.${year}${month}${day}.nc4
echo "Grabbing levels asm file for ${year}/${month}/${day}"
wget http://goldsmr5.sci.gsfc.nasa.gov/opendap/MERRA2/M2T3NVASM.5.12.4/${year}/${month}/MERRA2_400.tavg3_3d_asm_Nv.${year}${month}${day}.nc4



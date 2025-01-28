 #!/bin/bash

# currently hoping that baseline module environment does not break
# netCDF/HDF/NCO

year=$1
month=$2
VERS=$3

BASEDIR="/umbc/xfs3/strow/asl/merra2_monthly"
INCOMING=$BASEDIR/INCOMING

# NOTE: part of the process here is to rename variables and dimensions
# in the MERRA namespace to replicate those in the ERA
# namespace. Should changes be made in this mapping, they also must be
# reflected in the subsequent read statements in
# grib_interpolate_merra.m within rtp_prod2

if [ $year -lt 2011 ]; then
    VERS=300
else
    VERS=400
fi

echo "Processing ${year}/${month}"
LEVELSFILE=$INCOMING/merra2_${year}${month}_levels.nc4
echo "  Processing levels data..."
echo "    Extracting variables..."
ncks -v RH,T,QV,QL,QI,O3 $INCOMING/MERRA2_${VERS}.instM_3d_asm_Np.${year}${month}.nc4 -o $LEVELSFILE
ncks -v CLOUD $INCOMING/MERRA2_${VERS}.tavgM_3d_cld_Np.${year}${month}.nc4 -o $INCOMING/cloud.nc4

echo "    Appending variables..."
ncks -A $INCOMING/cloud.nc4 $LEVELSFILE

echo "    Renaming levels variables to match ERA..."
ncrename -h -O -v RH,rh -v T,t -v QV,q -v O3,o3 -v QL,clwc -v QI,ciwc -v CLOUD,cc  $LEVELSFILE
# rename dimension/variables (subject to bug in netcdf library where renaming either dimension or variable renames both. see http://nco.sourceforge.net/nco.html#ncrename-netCDF-Renamer)
ncrename -O -h -v lon,longitude -v lat,latitude -v lev,level $LEVELSFILE

echo "    Compressing levels netcdf file..."
nccopy -u -d9 $LEVELSFILE ${LEVELSFILE}.compressed

# echo "    Removing temporary files..."
# rm $INCOMING/cloud.nc4 $LEVELSFILE


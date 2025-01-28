 #!/bin/bash

# currently hoping that baseline module environment does not break
# netCDF/HDF/NCO

YEAR=$1
MONTH=$2

BASEDIR="/asl/models/merra2_monthly"
INCOMING=$BASEDIR/INCOMING


echo -e "\n**** Repackaging ${YEAR}/${MONTH}"
LEVELSFILE=$INCOMING/merra2_${YEAR}${MONTH}_levels.nc4
echo "---->Processing levels data..."
echo "---->Extracting variables..."
ncks -v RH,T,QV,QL,QI,O3 $INCOMING/MERRA2_*.instM_3d_asm_Np.${YEAR}${MONTH}.nc4 -o $LEVELSFILE
ncks -v CLOUD $INCOMING/MERRA2_*.tavgM_3d_cld_Np.${YEAR}${MONTH}.nc4 -o $INCOMING/cloud.nc4

echo "---->Appending variables..."
ncks -A $INCOMING/cloud.nc4 $LEVELSFILE

echo "---->Renaming levels variables to match ERA..."
ncrename -h -O -v RH,rh -v T,t -v QV,q -v O3,o3 -v QL,clwc -v QI,ciwc -v CLOUD,cc  $LEVELSFILE
# rename dimension/variables (subject to bug in netcdf library where
# renaming either dimension or variable renames both. see
# http://nco.sourceforge.net/nco.html#ncrename-netCDF-Renamer)
ncrename -O -h -v lon,longitude -v lat,latitude -v lev,level $LEVELSFILE

echo "---->Compressing levels netcdf file..."
nccopy -u -d9 $LEVELSFILE ${LEVELSFILE}.compressed



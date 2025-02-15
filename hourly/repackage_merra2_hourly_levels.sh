 #!/bin/bash

# currently hoping that baseline module environment does not break
# netCDF/HDF/NCO

YEAR=$1
MONTH=$2
DAY=$3

BASEDIR="/asl/models/merra2"
INCOMING=$BASEDIR/INCOMING


echo -e "\n**** Repackaging ${YEAR}/${MONTH}"
LEVELSFILE=$INCOMING/merra2_${YEAR}${MONTH}${DAY}_levels.nc4
echo "---->Processing levels data..."
echo "---->Extracting variables..."
ncks -v T,QV,QL,QI,O3,CLOUD,DELP $INCOMING/MERRA2_*.inst3_3d_asm_Nv.${YEAR}${MONTH}${DAY}.nc4 -o $INCOMING/merra2_${YEAR}${MONTH}${DAY}_levels.nc4
ncks -v SO2 $INCOMING/MERRA2_*.inst3_3d_aer_Nv.${YEAR}${MONTH}${DAY}.nc4 -o $INCOMING/so2.nc4
ncks -v CO $INCOMING/MERRA2_*.inst3_3d_chm_Nv.${YEAR}${MONTH}${DAY}.nc4 -o $INCOMING/co.nc4

echo "---->Appending variables..."
ncks -A $INCOMING/so2.nc4 $INCOMING/merra2_${YEAR}${MONTH}${DAY}_levels.nc4
ncks -A $INCOMING/co.nc4 $INCOMING/merra2_${YEAR}${MONTH}${DAY}_levels.nc4

echo "---->Renaming levels variables to match ERA..."
ncrename -h -O -v T,t -v QV,q -v O3,o3 -v QL,clwc -v QI,ciwc -v CLOUD,cc -v DELP,delp -v SO2,so2 -v CO,co $INCOMING/merra2_${YEAR}${MONTH}${DAY}_levels.nc4
# rename dimension/variables (subject to bug in netcdf library where renaming either dimension or variable renames both. see http://nco.sourceforge.net/nco.html#ncrename-netCDF-Renamer)
ncrename -O -h -v lon,longitude -v lat,latitude -v lev,level $INCOMING/merra2_${YEAR}${MONTH}${DAY}_levels.nc4

echo "---->Compressing levels netcdf file..."
nccopy -u -d9 $LEVELSFILE ${LEVELSFILE}.compressed



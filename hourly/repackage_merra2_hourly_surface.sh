 #!/bin/bash

# currently hoping that baseline module environment does not break
# netCDF/HDF/NCO

YEAR=$1
MONTH=$2
DAY=$3

BASEDIR="/asl/models/merra2"
INCOMING=$BASEDIR/INCOMING

echo -e "\n**** Repackaging ${YEAR}/${MONTH}/${DAY}"

echo "---->Processing surface data..."
SURFACEFILE=$INCOMING/merra2_${YEAR}${MONTH}${DAY}_surface.nc4
echo "---->Extracting variables..."
# to extract hours to match era use stride like "ncks -d time,0,,3 ..."
ncks -v CLDTOT $INCOMING/MERRA2_*.tavg1_2d_rad_Nx.${YEAR}${MONTH}${DAY}.nc4 -o $INCOMING/cldtot.nc4
ncks -v FRSEAICE $INCOMING/MERRA2_*.tavg1_2d_flx_Nx.${YEAR}${MONTH}${DAY}.nc4 -o $INCOMING/frseaice.nc4
ncks -v PS,U10M,V10M,TS $INCOMING/MERRA2_*.inst1_2d_asm_Nx.${YEAR}${MONTH}${DAY}.nc4 -o $INCOMING/merra2_${YEAR}${MONTH}${DAY}_surface.nc4

echo "---->Appending variables..."
ncks -A $INCOMING/frseaice.nc4 $INCOMING/merra2_${YEAR}${MONTH}${DAY}_surface.nc4
ncks -A $INCOMING/cldtot.nc4 $INCOMING/merra2_${YEAR}${MONTH}${DAY}_surface.nc4

echo "---->Renaming surface variables to match ERA..."
ncrename -h -O -v FRSEAICE,ci -v PS,sp -v CLDTOT,tcc -v U10M,u10 -v V10M,v10 -vTS,skt $INCOMING/merra2_${YEAR}${MONTH}${DAY}_surface.nc4
# rename dimension/variables (subject to bug in netcdf library where renaming either dimension or variable renames both. see http://nco.sourceforge.net/nco.html#ncrename-netCDF-Renamer)
ncrename -O -h -v lon,longitude -v lat,latitude $INCOMING/merra2_${YEAR}${MONTH}${DAY}_surface.nc4

echo "---->Compressing surface netcdf file..."
nccopy -u -d9 $SURFACEFILE ${SURFACEFILE}.compressed



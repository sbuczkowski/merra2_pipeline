 #!/bin/bash

year=$1
month=$2
day=$3

BASEDIR="/umbc/isilon/rs/strow/asl/merra2/incoming"

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

echo "Processing day $day"

echo "  Processing levels data..."
echo "    Extracting variables..."
ncks -v T,QV,QL,QI,O3,CLOUD,DELP $BASEDIR/MERRA2_${VERS}.inst3_3d_asm_Nv.${year}${month}${day}.nc4 -o $BASEDIR/merra2_${year}${month}${day}_levels.nc4
ncks -v SO2 $BASEDIR/MERRA2_${VERS}.inst3_3d_aer_Nv.${year}${month}${day}.nc4 -o $BASEDIR/so2.nc4
ncks -v CO $BASEDIR/MERRA2_${VERS}.inst3_3d_chm_Nv.${year}${month}${day}.nc4 -o $BASEDIR/co.nc4

echo "    Appending variables..."
ncks -A $BASEDIR/so2.nc4 $BASEDIR/merra2_${year}${month}${day}_levels.nc4
ncks -A $BASEDIR/co.nc4 $BASEDIR/merra2_${year}${month}${day}_levels.nc4

echo "    Renaming levels variables to match ERA..."
ncrename -h -O -v T,t -v QV,q -v O3,o3 -v QL,clwc -v QI,ciwc -v CLOUD,cc -v DELP,delp -v SO2,so2 -v CO,co $BASEDIR/merra2_${year}${month}${day}_levels.nc4
# rename dimension/variables (subject to bug in netcdf library where renaming either dimension or variable renames both. see http://nco.sourceforge.net/nco.html#ncrename-netCDF-Renamer)
ncrename -O -h -v lon,longitude -v lat,latitude -v lev,level $BASEDIR/merra2_${year}${month}${day}_levels.nc4

echo "    Removing temporary files..."
rm $BASEDIR/{so2,co}.nc4

################

echo "  Processing surface data..."
echo "    Extracting variables..."
# to extract hours to match era use stride like "ncks -d time,0,,3 ..."
ncks -v CLDTOT $BASEDIR/MERRA2_${VERS}.tavg1_2d_rad_Nx.${year}${month}${day}.nc4 -o $BASEDIR/cldtot.nc4
ncks -v FRSEAICE $BASEDIR/MERRA2_${VERS}.tavg1_2d_flx_Nx.${year}${month}${day}.nc4 -o $BASEDIR/frseaice.nc4
ncks -v PS,U10M,V10M,TS $BASEDIR/MERRA2_${VERS}.inst1_2d_asm_Nx.${year}${month}${day}.nc4 -o $BASEDIR/merra2_${year}${month}${day}_surface.nc4

echo "    Appending variables..."
ncks -A $BASEDIR/frseaice.nc4 $BASEDIR/merra2_${year}${month}${day}_surface.nc4
ncks -A $BASEDIR/cldtot.nc4 $BASEDIR/merra2_${year}${month}${day}_surface.nc4

echo "    Removing temporary files..."
rm $BASEDIR/{frseaice,cldtot}.nc4

echo "    Renaming surface variables to match ERA..."
ncrename -h -O -v FRSEAICE,ci -v PS,sp -v CLDTOT,tcc -v U10M,u10 -v V10M,v10 -vTS,skt $BASEDIR/merra2_${year}${month}${day}_surface.nc4
# rename dimension/variables (subject to bug in netcdf library where renaming either dimension or variable renames both. see http://nco.sourceforge.net/nco.html#ncrename-netCDF-Renamer)
ncrename -O -h -v lon,longitude -v lat,latitude $BASEDIR/merra2_${year}${month}${day}_surface.nc4

echo "Day $day done"


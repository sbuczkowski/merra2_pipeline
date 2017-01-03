 #!/bin/bash

year=$1
month=$2
day=$3

# NOTE: part of the process here is to rename variables and dimensions
# in the MERRA namespace to replicate those in the ERA
# namespace. Should changes be made in this mapping, they also must be
# reflected in the subsequent read statements in
# grib_interpolate_merra.m within rtp_prod2

echo "Processing day $day"

echo "  Processing levels data..."
ncks -v T,QV,QL,QI,O3,CLOUD,DELP MERRA2_400.inst3_3d_asm_Nv.${year}${month}${day}.nc4 -o merra2_${year}${month}${day}_levels.nc4
echo "    Renaming levels variables to match ERA..."
ncrename -h -O -v T,t -v QV,q -v O3,o3 -v QL,clwc -v QI,ciwc -v CLOUD,cc -v DELP,delp merra2_${year}${month}${day}_levels.nc4
# rename dimension/variables (subject to bug in netcdf library where renaming either dimension or variable renames both. see http://nco.sourceforge.net/nco.html#ncrename-netCDF-Renamer)
ncrename -O -h -v lon,longitude -v lat,latitude -v lev,level merra2_${year}${month}${day}_levels.nc4

echo "  Processing surface data..."
echo "    Extracting variables..."
# to extract hours to match era using stride like "ncks -d time,0,,3 ..."
ncks -v CLDTOT MERRA2_400.tavg1_2d_rad_Nx.${year}${month}${day}.nc4 -o cldtot.nc4
ncks -v FRSEAICE MERRA2_400.tavg1_2d_flx_Nx.${year}${month}${day}.nc4 -o frseaice.nc4
ncks -v PS,U10M,V10M,TS MERRA2_400.inst1_2d_asm_Nx.${year}${month}${day}.nc4 -o merra2_${year}${month}${day}_surface.nc4

echo "    Appending variables..."
ncks -A frseaice.nc4 merra2_${year}${month}${day}_surface.nc4
ncks -A cldtot.nc4 merra2_${year}${month}${day}_surface.nc4

echo "    Removing temporary files..."
rm frseaice.nc4 cldtot.nc4

echo "    Renaming surface variables to match ERA..."
ncrename -h -O -v FRSEAICE,ci -v PS,sp -v CLDTOT,tcc -v U10M,u10 -v V10M,v10 -vTS,skt merra2_${year}${month}${day}_surface.nc4
# rename dimension/variables (subject to bug in netcdf library where renaming either dimension or variable renames both. see http://nco.sourceforge.net/nco.html#ncrename-netCDF-Renamer)
ncrename -O -h -v lon,longitude -v lat,latitude merra2_${year}${month}${day}_surface.nc4

echo "Day $day done"


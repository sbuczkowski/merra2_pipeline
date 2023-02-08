 #!/bin/bash

# currently hoping that baseline module environment does not break
# netCDF/HDF/NCO

year=$1
month=$2
VERS=$3

BASEDIR="/umbc/xfs3/strow/asl/merra2_monthly"
INCOMING=$BASEDIR/incoming

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

echo "    Removing temporary files..."
rm $INCOMING/cloud.nc4 $LEVELSFILE
################

echo "  Processing surface data..."
SURFACEFILE=$INCOMING/merra2_${year}${month}_surface.nc4
echo "    Extracting variables..."
# to extract hours to match era use stride like "ncks -d time,0,,3 ..."
ncks -v CLDTOT $INCOMING/MERRA2_${VERS}.tavgM_2d_rad_Nx.${year}${month}.nc4 -o $INCOMING/cldtot.nc4
ncks -v FRSEAICE $INCOMING/MERRA2_${VERS}.tavgM_2d_flx_Nx.${year}${month}.nc4 -o $INCOMING/frseaice.nc4
ncks -v QV2M,PS,U10M,V10M,TS,T2M $INCOMING/MERRA2_${VERS}.instM_2d_asm_Nx.${year}${month}.nc4 -o $SURFACEFILE

echo "    Appending variables..."
ncks -A $INCOMING/frseaice.nc4 $SURFACEFILE
ncks -A $INCOMING/cldtot.nc4 $SURFACEFILE

echo "    Renaming surface variables to match ERA..."
ncrename -h -O -v QV2M,q2m -v FRSEAICE,ci -v PS,sp -v CLDTOT,tcc -v U10M,u10 -v V10M,v10 -vTS,skt -vT2M,t2m $SURFACEFILE
# rename dimension/variables (subject to bug in netcdf library where renaming either dimension or variable renames both. see http://nco.sourceforge.net/nco.html#ncrename-netCDF-Renamer)
ncrename -O -h -v lon,longitude -v lat,latitude $SURFACEFILE

echo "    Compressing surface netcdf file..."
nccopy -u -d9 $SURFACEFILE ${SURFACEFILE}.compressed

echo "    Removing temporary files..."
rm $INCOMING/{frseaice,cldtot}.nc4 $SURFACEFILE

rm $INCOMING/MERRA2_${VERS}.*.${year}${month}.nc4

echo "${year}/${month} repackaged"


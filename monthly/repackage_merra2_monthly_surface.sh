 #!/bin/bash

# currently hoping that baseline module environment does not break
# netCDF/HDF/NCO

YEAR=$1
MONTH=$2

BASEDIR="/asl/models/merra2_monthly"
INCOMING=$BASEDIR/INCOMING

echo -e "\n**** Repackaging ${YEAR}/${MONTH}"

echo "---->Processing surface data..."
SURFACEFILE=$INCOMING/merra2_${YEAR}${MONTH}_surface.nc4
echo "---->Extracting variables..."
# to extract hours to match era use stride like "ncks -d time,0,,3 ..."
ncks -v CLDTOT,LWGNT,LWGNTCLR,LWTUP,LWTUPCLR $INCOMING/MERRA2_*.tavgM_2d_rad_Nx.${YEAR}${MONTH}.nc4 -o $INCOMING/cldtot.nc4
ncks -v FRSEAICE $INCOMING/MERRA2_*.tavgM_2d_flx_Nx.${YEAR}${MONTH}.nc4 -o $INCOMING/frseaice.nc4
ncks -v QV2M,PS,U10M,V10M,TS,T2M $INCOMING/MERRA2_*.instM_2d_asm_Nx.${YEAR}${MONTH}.nc4 -o $SURFACEFILE

echo "---->Appending variables..."
ncks -A $INCOMING/frseaice.nc4 $SURFACEFILE
ncks -A $INCOMING/cldtot.nc4 $SURFACEFILE

echo "---->Renaming surface variables to match ERA..."
ncrename -h -O -v QV2M,q2m -v FRSEAICE,ci -v PS,sp -v CLDTOT,tcc -v U10M,u10 -v V10M,v10 -v TS,skt -v T2M,t2m \
  -v LWGNT,lwgnt -v LWGNTCLR,lwgntclr -v LWTUP,lwtup -v LWTUPCLR,lwtupclr $SURFACEFILE
# rename dimension/variables (subject to bug in netcdf library where renaming either dimension or variable renames both. see http://nco.sourceforge.net/nco.html#ncrename-netCDF-Renamer)
ncrename -O -h -v lon,longitude -v lat,latitude $SURFACEFILE

echo "---->Compressing surface netcdf file..."
nccopy -u -d9 $SURFACEFILE ${SURFACEFILE}.compressed



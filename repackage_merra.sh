#!/bin/bash

for day in {01..31}; do
    echo "Processing day $day"

    echo "  Processing levels data..."
    ncks -v T,QV,QL,QI,O3,CLOUD MERRA2_400.tavg3_3d_asm_Nv.201407${day}.nc4 -o merra2_201407${day}_levels.nc4

    echo "  Processing surface data..."
    echo "    Extracting variables..."
    ncks -v CLDTOT MERRA2_400.tavg1_2d_rad_Nx.201407${day}.nc4 -o cldtot.nc4
    ncks -v FRSEAICE MERRA2_400.tavg1_2d_flx_Nx.201407${day}.nc4 -o frseaice.nc4
    ncks -v PS,U10M,V10M,TS MERRA2_400.tavg1_2d_slv_Nx.201407${day}.nc4 -o merra2_201407${day}_surface.nc4

    echo "    Appending variables..."
    ncks -A frseaice.nc4 merra2_201407${day}_surface.nc4
    ncks -A cldtot.nc4 merra2_201407${day}_surface.nc4

    echo "    Removing temporary files..."
    rm frseaice.nc4 cldtot.nc4
    
    echo "Day $day done"
done

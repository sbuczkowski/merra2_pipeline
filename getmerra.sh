#!/bin/bash

for day in {01..31}; do

    echo "Grabbing surface slv file for day ${day}"
    wget http://goldsmr4.sci.gsfc.nasa.gov/opendap/MERRA2/M2T1NXSLV.5.12.4/2014/07/MERRA2_400.tavg1_2d_slv_Nx.201407${day}.nc4
    echo "Grabbing surface rad file day day ${day}"
    wget http://goldsmr4.sci.gsfc.nasa.gov/opendap/MERRA2/M2T1NXRAD.5.12.4/2014/07/MERRA2_400.tavg1_2d_rad_Nx.201407${day}.nc4
    echo "Grabbing surface flx file for day ${day}"
    wget http://goldsmr4.sci.gsfc.nasa.gov/opendap/MERRA2/M2T1NXFLX.5.12.4/2014/07/MERRA2_400.tavg1_2d_flx_Nx.201407${day}.nc4
    echo "Grabbing levels asm file for day ${day}"
    wget http://goldsmr5.sci.gsfc.nasa.gov/opendap/MERRA2/M2T3NVASM.5.12.4/2014/07/MERRA2_400.tavg3_3d_asm_Nv.201407${day}.nc4

done

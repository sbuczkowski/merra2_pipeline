#!/bin/bash

# take files like
# /home/sbuczko1/WorkingFiles/MERRA-2/MonthStartTimeseries/2005/merra2_20050101_levels.nc4
# and
# /home/sbuczko1/WorkingFiles/MERRA-2/MonthStartTimeseries/2005/merra2_20050101_surface.nc4
# and place into /asl/data/merra/2005/01/20050101_{lev,sfc}.nc

for year in {2002..2016}; do
    cd $year
    for mfile in *_levels.nc4; do
	tstamp=${mfile:7:8}
	tyear=${tstamp:0:4}
	tmonth=${tstamp:4:2}
	tday=${tstamp:6:2}

	# check for existence of output merra directory
	if [ ! -d /asl/data/merra/${tyear}/${tmonth} ]; then
	    echo "/asl/data/merra/${tyear}/${tmonth} does not exist. creating."
	    mkdir -p /asl/data/merra/${tyear}/${tmonth}
	fi

	# move and rename the levels and surface files
	cp merra2_${tstamp}_levels.nc4 /asl/data/merra/${tyear}/${tmonth}/${tstamp}_lev.nc
	cp merra2_${tstamp}_surface.nc4 /asl/data/merra/${tyear}/${tmonth}/${tstamp}_sfc.nc
    done
    cd ..
done

	

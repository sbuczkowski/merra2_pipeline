#!/bin/bash

year=$1
month=$2
day=$3

tstamp=${year}${month}${day}

#BASEDIR="/umbc/isilon/rs/strow/asl/merra2/incoming"
BASEDIR="/umbc/xfs3/strow/asl/merra2/incoming"
#OUTDIR="/umbc/isilon/rs/strow/asl/merra2/${year}/${month}"
OUTDIR="/umbc/xfs3/strow/asl/merra2/${year}/${month}"

# check for existence of output merra directory
if [ ! -d $OUTDIR ]; then
    echo "$OUTDIR does not exist. creating."
    mkdir -p $OUTDIR
fi

# move and rename the levels and surface files
mv $BASEDIR/merra2_${tstamp}_levels.nc4 $OUTDIR/${tstamp}_lev.nc
mv $BASEDIR/merra2_${tstamp}_surface.nc4 $OUTDIR/${tstamp}_sfc.nc


	

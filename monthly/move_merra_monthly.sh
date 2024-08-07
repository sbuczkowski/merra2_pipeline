#!/bin/bash

year=$1
month=$2

tstamp=${year}${month}

BASEDIR="/umbc/xfs3/strow/asl/merra2_monthly"
INCOMING="$BASEDIR/INCOMING"
OUTDIR="$BASEDIR/$year"

# check for existence of output merra directory
if [ ! -d $OUTDIR ]; then
    echo "$OUTDIR does not exist. creating."
    mkdir -p $OUTDIR
fi

# move and rename the levels and surface files
mv $INCOMING/merra2_${tstamp}_levels.nc4.compressed $OUTDIR/merra2_${tstamp}_lev.nc
mv $INCOMING/merra2_${tstamp}_surface.nc4.compressed $OUTDIR/merra2_${tstamp}_sfc.nc


	

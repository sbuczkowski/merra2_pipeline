#!/bin/bash

# move repackaged files from INCOMING to their respective YEAR
# directories in the archive

YEAR=$1
MONTH=$2

TSTAMP=${YEAR}${MONTH}

BASEDIR="/asl/models/merra2_monthly"
INCOMING="$BASEDIR/INCOMING"
OUTDIR="$BASEDIR/$YEAR"

echo -e "\n*** Moving repackaged files to archive"
# check for existence of output merra directory
if [ ! -d $OUTDIR ]; then
    echo "\t *** $OUTDIR does not exist. creating. ***"
    mkdir -p $OUTDIR
fi

# move and rename the levels and surface files
OFILE=$OUTDIR/merra2_${TSTAMP}_lev.nc
echo "--> Moving levels file to $OFILE"
mv $INCOMING/merra2_${TSTAMP}_levels.nc4.compressed $OFILE

OFILE=$OUTDIR/merra2_${TSTAMP}_sfc.nc
echo "--> Moving surface file to $OFILE"
mv $INCOMING/merra2_${TSTAMP}_surface.nc4.compressed $OFILE


	

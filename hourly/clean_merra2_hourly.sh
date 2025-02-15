#!/bin/bash

# Delete all MERRA2 base netcdf files and local processing
# intermediate netcdf files. 

# NOTE: this is not targeted, it just wipes any and all nc4 files in
# the INCOMING directory.

BASEDIR="/asl/models/merra2"
INCOMING=$BASEDIR/INCOMING

echo "*** Removing remaining nc4 files"
rm $INCOMING/*.nc4


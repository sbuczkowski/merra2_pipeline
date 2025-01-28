#!/bin/bash

year=$1
month=$2

BASEDIR="/asl/models/merra2_monthly"
INCOMING=$BASEDIR/INCOMING

tstamp=${year}${month}

echo "**> Removing remaining nc4 files"
rm $INCOMING/*.nc4


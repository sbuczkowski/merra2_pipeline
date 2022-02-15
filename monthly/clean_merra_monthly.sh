#!/bin/bash

year=$1
month=$2

BASEDIR="/umbc/xfs3/strow/asl/merra2/"
INCOMING=$BASEDIR/incoming

tstamp=${year}${month}

rm $INCOMING/*.nc4


#!/bin/bash

year=$1
month=$2
day=$3

BASEDIR="/umbc/isilon/rs/strow/asl/merra2/incoming"

tstamp=${year}${month}${day}

rm $BASEDIR/*${tstamp}*.nc4

#!/bin/bash

# Download function to retrieve MERRA2 files necessary for either
# hourly ECMWF model type file creation or monthly

# DEPENDENCIES:
# wget
# lftp
# User must also have valid Earthdata login credentials in their ~/.netrc

BASEDIR="/asl/models/merra2/INCOMING"


## Hourly
# echo "--> levels asm file"
# M2I3NVASM.5.12.4  MERRA2_${VERS}.inst3_3d_asm_Nv.${year}${month}${day}.nc4
# echo "--> levels aer (SO2) file"
# M2I3NVAER.5.12.4  MERRA2_${VERS}.inst3_3d_aer_Nv.${year}${month}${day}.nc4
# echo "--> levels chm (CO) file"
# M2I3NVCHM.5.12.4  MERRA2_${VERS}.inst3_3d_chm_Nv.${year}${month}${day}.nc4

# echo "--> surface asm file"
# M2I1NXASM.5.12.4  MERRA2_${VERS}.inst1_2d_asm_Nx.${year}${month}${day}.nc4
# echo "--> surface rad file"
# M2T1NXRAD.5.12.4  MERRA2_${VERS}.tavg1_2d_rad_Nx.${year}${month}${day}.nc4
# echo "--> surface flx file"
# M2T1NXFLX.5.12.4  MERRA2_${VERS}.tavg1_2d_flx_Nx.${year}${month}${day}.nc4


while getopts "L:S:" flag; do
    case "$flag" in
	L) # levels
	    BASEURL="https://goldsmr5.gesdisc.eosdis.nasa.gov/data/MERRA2/"
	    TYPE="levels"
	    case $OPTARG in
		"asm")
		    MABBREV="asm"
		    MCODE="M2I3NVASM.5.12.4"
		    MFILE="inst3_3d_asm_Nv"
		    ;;
		"aer")
		    MABBREV="aer"
		    MCODE="M2I3NVAER.5.12.4"
		    MFILE="inst3_3d_aer_Nv"
		    ;;
		"chm")
		    MABBREV="chm"
		    MCODE="M2I3NVCHM.5.12.4"
		    MFILE="inst3_3d_chm_Nv"
		    ;;

	    esac
	    ;;
	S) # surface
	    BASEURL="https://goldsmr4.gesdisc.eosdis.nasa.gov/data/MERRA2/"
	    TYPE="surface"
	    case $OPTARG in
		"asm")
		    MABBREV="asm"
		    MCODE="M2I1NXASM.5.12.4"
		    MFILE="inst1_2d_asm_Nx"
		    ;;
		"rad")
		    MABBREV="rad"
		    MCODE="M2T1NXRAD.5.12.4"
		    MFILE="tavg1_2d_rad_Nx"
		    ;;
		"flx")
		    MABBREV="flx"
		    MCODE="M2T1NXFLX.5.12.4"
		    MFILE="tavg1_2d_flx_Nx"
		    ;;
	    esac
	    ;;
    esac

done
# make the year/month position paramters available
shift $(($OPTIND - 1))

YEAR=$1
MONTH=$2
DAY=$3

# Check for existence of incoming directory. Create if necessary
if [[ ! -d $BASEDIR ]]; then
    mkdir -p $BASEDIR
fi

# Filenames have differing versions before/after blocks of years. Need
# to select correct one based upon input year (VERS also goes down to
# 200 in years prior to 2002 but, we are concerned with AIRS lifespan
# at most for now). Have to watch out for when version jumps to 500
# (no a priori idea when this might happen or how we will find out;
# other than script failure)
if [ -z "$VERS" ]; then
    if [ $YEAR -lt 2011 ]; then
	VERS=300
    else
	VERS=400
    fi
fi

# wget boilerplate (user must have valid NASA Earthdata login with
# credentials stored in their ~/.netrc file)
BOILERPLATE="-nv --load-cookies ${HOME}/.urs_cookies --save-cookies ${HOME}/.urs_cookies --auth-no-challenge=on --keep-session-cookies"

echo -e "\n***** Grabbing ${TYPE} ${MABBREV} files for ${YEAR}/${MONTH}/${DAY}"
MDURL=${BASEURL}/${MCODE}/${YEAR}/${MONTH}
MFURL=${MDURL}/MERRA2_${VERS}.${MFILE}.${YEAR}${MONTH}${DAY}.nc4

echo -e "----->Attempting to grab $MFURL via wget"

wget $BOILERPLATE --directory-prefix=$BASEDIR $MFURL

if [[ $? -eq 8 ]]; then
# wget encountered an error (likely 404 File not found because of versioning error)
# Let's see if we can find the file we need through other methods.
### If you are seeing this path execute on a lot of files (especially
### sequentially starting from some epoch, they may have added a new
### overall version (i.e. 500)). If so, add a trap in the VERS block above.

    echo -e "\n\t *** wget failure (Likely 404 File Not Found due to inconsistent versioning)\n"
    echo -e "\t *** Attempting to find correct filename (This may take a few minutes).\n"
    MFURL=$(lftp -c du -a ${MDURL} |& grep "${YEAR}${MONTH}${DAY}.nc4.xml" | cut -f2 )
    MVFILE=$(basename $MFURL .xml)
    echo -e "\t *** Found file $MVFILE. Attempting to download via wget.\n"
    wget $BOILERPLATE --directory-prefix=$BASEDIR $MVFILE
fi

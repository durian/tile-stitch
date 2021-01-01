#!/bin/bash
#
TILE=http://a.tile.openstreetmap.org/{z}/{x}/{y}.png
SIZE=1280
#
MAPN=ESMM
CLAT=55.538745
CLON=13.361064

#echo ./stitch -o ${NAME} -x -- 56.0 12.4 56.5 13.5 ${ZOOM} ${TILE}
#./stitch -o ${NAME} -x -- 56.0 12.4 56.5 13.5 ${ZOOM} ${TILE}

# This script expects the stich binary to be in the same
# folder.
command -v ./stitch >/dev/null 2>&1 || {
    echo >&2 "I require ./stitch!"
    exit 1
}

# Post-processing.
function normalise {
    if command -v mogrify >/dev/null 2>&1; then
	#mogrify -normalize "${1}"
	#mogrify -gamma 64 "${1}"
	mogrify +contrast +contrast +contrast +contrast "${1}"
	#mogrify +contrast -auto-level "${1}"
    fi
}

function do_stitch {
    echo ./stitch -o $1 -x -c -- ${CLAT} ${CLON} ${SIZE} ${SIZE} $2 ${TILE}
    ./stitch -o $1 -x -c -- ${CLAT} ${CLON} ${SIZE} ${SIZE} $2 ${TILE}
}

for ZOOM in 8 10 12; do
    NAME=$( printf "map_${MAPN}_Z%02d.png" ${ZOOM} )
    if [ ! -e ${NAME} ]; then
	do_stitch ${NAME} ${ZOOM} 
	normalise ${NAME}
    else
	echo "${NAME} exists!"
    fi
done

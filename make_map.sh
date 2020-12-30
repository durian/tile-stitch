#!/bin/bash
#
MAPN=ESTA
TILE=http://a.tile.openstreetmap.org/{z}/{x}/{y}.png
ZOOM=8
SIZE=1200
#CLAT=56.292109
#CLON=12.854471
MAPN=RH118
CLAT=56.053821
CLON=13.530892

#echo ./stitch -o ${NAME} -x -- 56.0 12.4 56.5 13.5 ${ZOOM} ${TILE}
#./stitch -o ${NAME} -x -- 56.0 12.4 56.5 13.5 ${ZOOM} ${TILE}

command -v ./stitch >/dev/null 2>&1 || {
    echo >&2 "I require ./stitch!"
    exit 1
}

function normalise {
    if command -v mogrify >/dev/null 2>&1; then
	#mogrify -normalize "${1}"
	#mogrify -gamma 64 "${1}"
	mogrify +contrast +contrast +contrast +contrast "${1}"
	#mogrify +contrast -auto-level "${1}"
    fi
}

function stitch {
    echo ./stitch -o $1 -x -c -- ${CLAT} ${CLON} ${SIZE} ${SIZE} $2 ${TILE}
    ./stitch -o $1 -x -c -- ${CLAT} ${CLON} ${SIZE} ${SIZE} $2 ${TILE}
}

for ZOOM in 12 13 14 15 16 17 18 19; do
    NAME=$( printf "map_${MAPN}_Z%02d.png" ${ZOOM} )
    if [ ! -e ${NAME} ]; then
	stitch ${NAME} ${ZOOM} 
	normalise ${NAME}
    else
	echo "${NAME} exists!"
    fi
done

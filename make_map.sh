#!/bin/sh
#
TILE=http://a.tile.openstreetmap.org/{z}/{x}/{y}.png
ZOOM=8
NAME=map_TMP_z${ZOOM}.png

echo ./stitch -o ${NAME} -x -- 56.0 12.4 56.5 13.5 ${ZOOM} ${TILE}
./stitch -o ${NAME} -x -- 56.0 12.4 56.5 13.5 ${ZOOM} ${TILE}

# If installed we normalise the colours.
if command -v mogrify >/dev/null 2>&1; then
    echo mogrify -normalize $NAME
    mogrify -normalize $NAME
fi

tile-stitch
===========

Stitch together and crop map tiles for any bounding box.

The tiles should come from a web map service in PNG or JPEG format, and will be written out as PNG or a georeferenced TIFF.

Optionally, a separate worldfile with georeferencing data can be written.

X-Plane
-------

The `-x` option creates a map definition file for the X-Trident Harrier and Tornado aicraft. It will have the same
name as the output PNG file, with the `png` suffix changed to `map`.

Examples
--------

A map around ESTA airport for X-Plane:

    $ ./stitch -o map_ESTA_z11.png -x -- 56.0 12.4 56.5 13.5 11 http://a.tile.openstreetmap.org/{z}/{x}/{y}.png

Map centred around LOWI, 1280x1280 pixels.

    $ ./stitch -o map_LOWI_z11.png -x -c 47.2602 11.3438 1280 1280 11 http://a.tile.openstreetmap.org/{z}/{x}/{y}.png

Around Montreal (note the --):

    $ ./stitch -o CYUL10.png -c -- 45.4659097 -73.7429809 2400 2400 10 http://a.tile.openstreetmap.org/{z}/{x}/{y}.png
    
A bash script has been provided to make map making a bit easier. It loops over a number
of zoom levels and creates a 1280x1280 map around a user specified centre.


To get standard OpenStreetMap tiles at zoom level 10 for the area of the Exploratorium's Bay Model video projection:

    $ ./stitch -o baymodel.png -- 37.371794 -122.917099 38.226853 -121.564407 10 http://a.tile.openstreetmap.org/{z}/{x}/{y}.png

To do the same, but outputting a TIFF with a TFW world file:

    $ ./stitch -f geotiff -w -o baymodel.tif -- 37.371794 -122.917099 38.226853 -121.564407 10 http://a.tile.openstreetmap.org/{z}/{x}/{y}.png

To get the MapQuest Open Aerial imagery at zoom level 11 to match the "See Something or Say Something" bounding box of London:

    $ ./stitch -o london.png -- 51.316252 -0.366258 51.606525 0.099606 11 http://otile1.mqcdn.com/tiles/1.0.0/sat/{z}/{x}/{y}.jpg

To get a 640x480 image from Stamen's watercolor map at zoom level 10 around Tokyo:

    $ ./stitch -o tokyo.png -c -- 35.6824 139.7531 640 480 10 http://b.tile.stamen.com/watercolor/{z}/{x}/{y}.jpg

To get an image using 512x512 retina tiles of Stamen's Toner map at zoom level 14 around Köln:

    $ ./stitch -o köln.png -t 512 -- 50.88 6.88 50.98 7.04 14 http://b.tile.stamen.com/toner/{z}/{x}/{y}@2x.png

Format
------

The arguments are <i>minlat minlon maxlat maxlon zoom url</i>. If you don't specify <i>-o outfile</i> the PNG will be
written to the standard output. URLs should include <i>{z}, {x},</i> and <i>{y}</i> tokens for tile zoom, x, and y.

The <code>--</code> is to keep getopt, especially GNU getopt, from interpreting the minus signs in latitudes or longitudes
as option flags.

Restrictions
------------
GeoTIFF is currently only supported when an output filename is specified.
A worldfile cannot be generated unless an output filename is specified.

Requirements
------------

  * pkg-config
  * libcurl to retrieve the tiles
  * libjpeg >= 8 for jpeg_mem_src
  * libpng
  * libtiff
  * libgeotiff

Installation
------------

To install on Ubuntu do:

    sudo apt-get update
    sudo apt-get install git build-essential pkg-config libcurl4-openssl-dev libpng-dev libjpeg-dev libtiff-dev libgeotiff-dev
    git clone git@github.com:durian/tile-stitch.git
    cd tile-stitch
    make

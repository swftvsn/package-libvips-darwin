+#!/bin/bash

# Clean working directories
export GI_TYPELIB_PATH=/usr/local/lib/girepository-1.0:$VIPSHOME/lib/girepository-1.0
export PYTHONPATH=$VIPSHOME/lib/python2.7/site-packages:$PYTHONPATH

# Use pkg-config to automagically find and copy necessary header files
git clone git@github.com:jcupitt/libvips.git
cd libvips

CFLAGS="-g -Wall" CXXFLAGS="-g -Wall" ./autogen.sh --prefix=$HOME/vips --with-jpeg-includes=/usr/local/opt/jpeg-turbo/include --with-jpeg-libraries=/usr/local/opt/jpeg-turbo/lib --with-pdfium-includes=../pdfium/include --with-pdfium-libraries=../pdfium/lib
make
make install

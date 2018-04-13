#!/bin/bash

. config.sh

export GI_TYPELIB_PATH=/usr/local/lib/girepository-1.0:$VIPSHOME/lib/girepository-1.0
export PYTHONPATH=$VIPSHOME/lib/python2.7/site-packages:$PYTHONPATH

# Clone master
if [ ! -d "${BASE}/libvips" ]; then
  ${git} clone https://github.com/jcupitt/libvips.git
  cd libvips
else
  cd libvips
  ${git} pull
fi

# Build, make and install
export PDFIUM_INCLUDES="${BASE}/pdfium/include"
export PDFIUM_LIBS="${BASE}/pdfium/lib"
echo ${PDFIUM_INCLUDES}
CFLAGS="-g -Wall" CXXFLAGS="-g -Wall" ./autogen.sh --prefix=$BASE/libvips-build --with-jpeg-includes=/usr/local/opt/jpeg-turbo/include --with-jpeg-libraries=/usr/local/opt/jpeg-turbo/lib --with-pdfium-includes=$PDFIUM_INCLUDES --with-pdfium-libraries=$PDFIUM_LIBS
make
make install

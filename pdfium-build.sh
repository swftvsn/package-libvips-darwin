#!/bin/bash

set -e

. config.sh

# rm -rf ${BUILD_DIR}
# mkdir -p ${BUILD_DIR}
cd ${BUILD_DIR}

DEPOT_TOOLS="${BUILD_DIR}/depot_tools"

if [ ! -d "${DEPOT_TOOLS}" ]; then
    ${git} clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
fi

export PATH="${DEPOT_TOOLS}":"$PATH"

gclient config --unmanaged https://pdfium.googlesource.com/pdfium.git
gclient sync --no-history

cd pdfium

gn gen "${BUILD_RES}" --args='pdf_bundle_freetype = true pdf_enable_v8 = false pdf_enable_xfa = false pdf_use_skia = false pdf_use_skia_paths = false is_component_build = false pdf_is_complete_lib = true use_sysroot = false'

ninja -C "${BUILD_RES}"
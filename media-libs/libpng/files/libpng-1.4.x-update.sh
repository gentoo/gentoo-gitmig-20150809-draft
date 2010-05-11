#!/bin/bash

echo "Run revdep-rebuild before this. This brute force script will rename"
echo "rest of -lpng12 and libpng12.la entries in your systems .la files."

[[ -d /usr/lib64 ]] && lib_suffix=64

libdir=/usr/lib${lib_suffix}

find ${libdir} -name '*.la' | xargs sed -i -e '/^dependency_libs/s:-lpng12:-lpng14:'
find ${libdir} -name '*.la' | xargs sed -i -e '/^dependency_libs/s:libpng12.la:libpng14.la:'

# WTFPL-2

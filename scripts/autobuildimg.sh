#!/bin/bash

export USE=build
export CFLAGS="-O2 -mcpu=i486 -march=i486 -O2 -pipe"
export CXXFLAGS="${CFLAGS}"
export CHOST="i486-pc-linux-gnu"
export ROOT=/tmp/autobuildimg
export STEPS="clean unpack compile install qmerge clean"

TODAY=`date '+%Y%m%d'`

[ -z "${PORTDIR}" ] && PORTDIR=/usr/portage
[ -z "${BUILDTARBALL}" ] && BUILDTARBALL="build-${TODAY}.tbz2"
[ -z "${BUILD_PACKAGES}" ] && BUILD_PACKAGES=`ls -1 ${PORTDIR}/files/build-*.packages | sort | tail -1`

echo ">>> Cleaning up ${ROOT}..."
rm -rf "${ROOT}"
mkdir -p "${ROOT}"

scripts/autocompile.sh "${BUILD_PACKAGES}"

rm -rf "${ROOT}/tmp"
mkdir -p ${ROOT}/tmp
chown root.root ${ROOT}/tmp
chmod 1777 ${ROOT}/tmp

echo ">>> Creating ${BUILDTARBALL}..."
cd ${ROOT}
tar -cj --numeric-owner -p -f "${PORTDIR}/distribution/${BUILDTARBALL}" .

rm -rf ${ROOT}

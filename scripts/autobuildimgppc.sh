#!/bin/bash

#I'm not sure who wrote the original autobuildimg.sh script, but thanks for
#the framework.

cleanup() {
	cp /etc/make.conf.build /etc/make.conf
	exit $1
}

export USE="-* build bootstrap"
export CFLAGS=" -O2 -mpowerpc -pipe "
export CXXFLAGS="${CFLAGS}"
export CHOST="powerpc-unknown-linux-gnu"
#export ORIGUSE="`$PYTHON -c 'import portage; print portage.settings["USE"];'`"
export CONFIG_PROTECT=""
#export GENTOO_MIRRORS="`$PYTHON -c 'import portage; print portage.settings["GENTOO_MIRRORS"];'`"
export ROOT=/mnt/build-img
cp /etc/make.conf /etc/make.conf.build
#export STEPS="clean unpack compile install qmerge clean"

TODAY=`date '+%Y%m%d'`

[ -z "${PORTDIR}" ] && PORTDIR=/usr/portage
cp ${PORTDIR}/profiles/default-ppc-1.0/make.conf.buildimg /etc/make.conf
[ -z "${BUILDTARBALL}" ] && BUILDTARBALL="build-${TODAY}.tbz2"
#[ -z "${BUILD_PACKAGES}" ] && BUILD_PACKAGES=`ls -1 ${PORTDIR}/files/build-*.packages | sort | tail -1`
mkdir -p ${PORTDIR}/distribution

echo ">>> Cleaning up ${ROOT}..."
rm -rf "${ROOT}"
mkdir -p "${ROOT}"

#scripts/autocompile.sh "${BUILD_PACKAGES}"
emerge baselayout || cleanup 1
emerge glibc || cleanup 1
emerge portage || cleanup 1
emerge `cat /etc/make.profile/packages.build` || cleanup 1
rm -rf "${ROOT}/tmp"
mkdir -p ${ROOT}/tmp
chown root.root ${ROOT}/tmp
chmod 1777 ${ROOT}/tmp
mv ${ROOT}/var/db/pkg ${ROOT}/var/db/pkg.build

echo ">>> Creating ${BUILDTARBALL}..."
cd ${ROOT}
tar -cj --numeric-owner -p -f "${PORTDIR}/distribution/${BUILDTARBALL}" .

rm -rf ${ROOT}
cleanup 0

#!/bin/bash

export CFLAGS="-O2 -mcpu=i486 -march=i486 -O2 -pipe"
export CXXFLAGS="${CFLAGS}"
export CHOST="i486-pc-linux-gnu"
export SYSIMG_ROOT=/tmp/autosysimg
export STEPS="clean unpack compile install qmerge clean"
[ -z "${USE}" ] || USE="slang readline gpm tcpd pam libwww ssl nls perl python oss"

TODAY=`date '+%Y%m%d'`

[ -z "${PORTDIR}" ] && PORTDIR=/usr/portage
[ -z "${BUILD_TARBALL}" ] && BUILD_TARBALL=`ls -1 ${PORTDIR}/distribution/build-*.tbz2 2> /dev/null | sort | tail -1`
if [ -z "${BUILD_TARBALL}" ]
then
    echo "You must create a build tarball before running this script."
    exit 1
fi
[ -z "${SYS_PACKAGES}" ] && SYS_PACKAGES=`ls -1 ${PORTDIR}/distribution/sys-*.tbz2 2> /dev/null | sort | tail -1`
[ -z "${BOOTSTRAP_PACKAGES}" ] && SYS_PACKAGES=`ls -1 ${PORTDIR}/files/bootstrap-*.packages 2> /dev/null | sort | tail -1`
[ -z "${SYS_TARBALL}" ] && SYS_TARBALL="sys-${TODAY}.tbz2"
mkdir -p ${PORTDIR}/distribution

echo ">>> Cleaning up ${SYSIMG_ROOT}..."
rm -rf "${SYSIMG_ROOT}"
mkdir -p "${SYSIMG_ROOT}"

mount --bind ${PORTDIR} ${SYSIMG_ROOT}/${PORTDIR}
mkdir ${SYSIMG_ROOT}/scripts
chroot bash -c "cd ${PORTDIR} ; ROOT=/sysimg scripts/bootstrap.sh ${BOOTSTRAP_PACKAGES}"
chroot bash -c "cd ${PORTDIR} ; scripts/autocompile.sh ${SYS_PACKAGES}"

# now unmerge the build packages
mv ${SYSIMG_ROOT}/var/db/pkg ${SYSIMG_ROOT}/var/db/pkg.new
mv ${SYSIMG_ROOT}/var/db/pkg.build ${SYSIMG_ROOT}/var/db/pkg
FIRSTDIR=`pwd`
cd ${SYSIMG_ROOT}/var/db/pkg
for ebuildfile in `find . -type f -name '*.ebuild'`
do
  ROOT=${SYSIMG_ROOT} ebuild ${ebuildfile} unmerge
done
rm -rf ${SYSIMG_ROOT}/var/db/pkg
mv ${SYSIMG_ROOT}/var/db/pkg.new ${SYSIMG_ROOT}/var/db/pkg
umount ${SYSIMG_ROOT}/${PORTDIR}

rm -rf "${SYSIMG_ROOT}/tmp"
mkdir -p ${SYSIMG_ROOT}/tmp
chown root.root ${SYSIMG_ROOT}/tmp
chmod 1777 ${SYSIMG_ROOT}/tmp
mv ${SYSIMG_ROOT}/var/db/pkg ${ROOT}/var/db/pkg.build

echo ">>> Creating ${SYS_TARBALL}..."
cd ${SYSIMG_ROOT}
tar -cj --numeric-owner -p -f "${PORTDIR}/distribution/${SYS_TARBALL}" .

rm -rf ${SYSIMG_ROOT}

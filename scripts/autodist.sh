#!/bin/bash

TODAY=`date '+%Y%m%d'`

# ok, this script builds:
#
# 1. the build tarball
# 2. the sys tarball
# 3. the build iso
# 4. the sys iso (with all packages)

[ -z "${PORTDIR}" ] && PORTDIR="/usr/portage"
[ -z "${DISTRODIR}" ] && DISTRODIR="${PORTDIR}/distribution"
[ -z "${AUTODISTDIR}" ] && AUTODISTDIR="/tmp/autodist"
BUILDROOT="${AUTODISTDIR}/buildroot"
ISOROOT="${AUTODISTDIR}/isoroot"
INITRDROOT="${AUTODISTDIR}/initrdroot"
[ -z "${BUILDTARBALL}" ] && BUILDTARBALL="build-${TODAY}.tbz2"
[ -z "${SYSTARBALL}" ] && SYSTARBALL="sys-${TODAY}.tbz2"
# shouldn't allow CFLAGS to be overridden
export CFLAGS="-O2 -mcpu=i486 -march=i486"

[ -d "${DISTRODIR}" ] || mkdir -p "${DISTRODIR}"

[ -z "${ISOINITRD_PACKAGES}" ] && ISOINITRD_PACKAGES=`ls -1 ${PORTDIR}/files/isoinitrd-*.packages | sort | tail -1`
[ -z "${BUILD_PACKAGES}" ] && BUILD_PACKAGES=`ls -1 ${PORTDIR}/files/build-*.packages | sort | tail -1`
[ -z "${SYS_PACKAGES}" ] && SYS_PACKAGES=`ls -1 ${PORTDIR}/files/sys-*.packages | sort | tail -1`
[ -z "${KERNEL_SRC}" ] && KERNEL_SRC="/usr/src/`readlink /usr/src/linux`"
[ -z "${KERNEL_VERSION}" ] && KERNEL_VERSION="`echo ${KERNEL_SRC} | sed 's,.*-\([0-9]\.[0-9]\.[0-9]\+\(-ac[0-9]\+\)\?\)$,\1,'`"

[ -z "${INITRD_USE}" ] && INITRD_USE="bootcd lvm ext3"

export PORTDIR
export DISTRODIR
export AUTODISTDIR
 
if grep -qs "${AUTODISTDIR}" /proc/mounts
then
    cat << @@@ 1>&2
${AUTODISTDIR} was found in /proc/mounts.  If you have anything
mounted under ${AUTODISTDIR} using --bind, you should press ^C now and
unmount it, since ${AUTODISTDIR} is cleaned out by this script.  (This
is probably the case if you have run this script and interrupted it
before it completed.)  Note that this is just a safety precaution, and
if ${AUTODISTDIR} is a separate partition in itself, you might be OK.

Press ENTER to continue.
@@@
    read
fi

echo ">>> Using PORTDIR=${PORTDIR}"
echo ">>> Using AUTODISTDIR=${AUTODISTDIR}"
echo ">>> Using BUILDROOT=${BUILDROOT}"
echo ">>> Using ISOROOT=${ISOROOT}"
echo ">>> Using INITRDROOT=${INITRDROOT}"
echo ">>> Using ISOINITRD_PACKAGES=${ISOINITRD_PACKAGES}"
echo ">>> Using BUILD_PACKAGES=${BUILD_PACKAGES}"
echo ">>> Using SYS_PACKAGES=${SYS_PACKAGES}"
echo ">>> Using KERNEL_SRC=${KERNEL_SRC}"
echo ">>> Using KERNEL_VERSION=${KERNEL_VERSION}"

echo ">>> Cleaning up ${AUTODISTDIR}..."
rm -rf ${AUTODISTDIR}

echo ">>> Creating ISO directory tree..."
mkdir -pv ${ISOROOT}/{doc,gentoo{,/distfiles,/packages{,/All}},isolinux{,/kernels},stuff}

echo ">>> Building initrd packages..."
mkdir -p ${INITRDROOT}
ERRQUIT=yes CHECK=no USE="${INITRD_USE}" ROOT="${INITRDROOT}" STEPS="clean unpack compile install qmerge clean" ${PORTDIR}/scripts/autocompile.sh ${ISOINITRD_PACKAGES}
if [ ${?} != 0 ]
then
    echo "Error building initrd packages, quitting"
    exit 1
fi
echo ">>> Cleaning up ${INITRDROOT}/tmp"
rm -rf ${INITRDROOT}/tmp
mkdir -p ${INITRDROOT}/tmp
chown root.root ${INITRDROOT}/tmp
chmod 1777 ${INITRDROOT}/tmp

echo ">>> Setting up initrd..."
find ${INITRDROOT}/etc -name "*._cfg_*" exec rm -vf {} \;
ROOT=${INITRDROOT} rc-update autogen boot force
ROOT=${INITRDROOT} rc-update autogen normal force
ROOT=${INITRDROOT} rc-update autogen halt force

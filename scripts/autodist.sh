#!/bin/bash

runlog () {
    echo "Running ${1+${@}}..." 1>&3
    ${1+"${@}"} 1>&3 2>&1
    echo 1>&3
}

TODAY=`date '+%Y%m%d'`
FIRSTDIR=`pwd`

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
INITRDIMG="${AUTODISTDIR}/initrdimg"
USRIMG="${AUTODISTDIR}/usrimg"
[ -z "${BUILDTARBALL}" ] && BUILDTARBALL="build-${TODAY}.tbz2"
[ -z "${SYSTARBALL}" ] && SYSTARBALL="sys-${TODAY}.tbz2"
# shouldn't allow CFLAGS to be overridden
export CFLAGS="-O2 -mcpu=i486 -march=i486"
export CXXFLAGS="${CFLAGS}"
export CHOST="i486-pc-linux-gnu"

[ -d "${DISTRODIR}" ] || mkdir -p "${DISTRODIR}"
[ -z "${CONTINUE}" ] && CONTINUE=no
if [ "${CONTINUE}" = "yes" ]
then
    CHECK=yes
fi

[ -z "${ISOINITRD_PACKAGES}" ] && ISOINITRD_PACKAGES=`ls -1 ${PORTDIR}/files/isoinitrd-*.packages | sort | tail -1`
[ -z "${BUILD_PACKAGES}" ] && BUILD_PACKAGES=`ls -1 ${PORTDIR}/files/build-*.packages | sort | tail -1`
[ -z "${SYS_PACKAGES}" ] && SYS_PACKAGES=`ls -1 ${PORTDIR}/files/sys-*.packages | sort | tail -1`
[ -z "${KERNEL_SRC}" ] && KERNEL_SRC="/usr/src/`readlink /usr/src/linux`"
[ -z "${KERNEL_VERSION}" ] && KERNEL_VERSION="`echo ${KERNEL_SRC} | sed 's,.*-\([0-9]\.[0-9]\.[0-9]\+\(-ac[0-9]\+\)\?\)$,\1,'`"

[ -z "${INITRD_USE}" ] && INITRD_USE="bootcd lvm ext3"
# size of the initrd in kbytes
[ -z "${INITRD_SIZE}" ] && INITRD_SIZE=24576
[ -z "${INITRD_BSIZE}" ] && INITRD_BSIZE=4096
[ -z "${LOOPDEV}" ] && LOOPDEV=/dev/loop/0
# check to see if this loop device is in use
if losetup ${LOOPDEV} &> /dev/null
then
    echo "${LOOPDEV} is in use. Please specify another loop device by"
    echo "setting the environment variable LOOPDEV."
    exit 1
fi

exec 3> ${AUTODISTDIR}/autodist.log

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

if [ "${CONTINUE}" != "yes" ]
then
    echo ">>> Cleaning up ${AUTODISTDIR}..."
    rm -rf ${AUTODISTDIR}
fi

echo ">>> Creating ISO directory tree..."
mkdir -pv ${ISOROOT}/{doc,gentoo{,/distfiles,/packages{,/All}},isolinux{,/kernels},stuff}

echo ">>> Building initrd packages..."
mkdir -p ${INITRDROOT}
ERRQUIT=yes CHECK="${CHECK}" USE="${INITRD_USE}" ROOT="${INITRDROOT}" STEPS="clean unpack compile install qmerge clean" ${PORTDIR}/scripts/autocompile.sh ${ISOINITRD_PACKAGES}
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
find ${INITRDROOT}/etc -name "*._cfg_*" -exec rm -vf {} \;
ROOT=${INITRDROOT} rc-update autogen boot force
ROOT=${INITRDROOT} rc-update autogen normal force
ROOT=${INITRDROOT} rc-update autogen halt force

echo ">>> Creating initrd.img..."
# /usr goes in its own image
if [ "${CONTINUE}" != "yes" ] || [ ! -d ${AUTODISTDIR}/initrdusr ]
then
    mv ${INITRDROOT}/usr ${AUTODISTDIR}/initrdusr
    mkdir ${INITRDROOT}/usr
fi

runlog dd if=/dev/zero of=${AUTODISTDIR}/initrd.img bs=${INITRD_SIZE} count=1024
runlog losetup ${LOOPDEV} ${AUTODISTDIR}/initrd.img
runlog mke2fs ${LOOPDEV}
mkdir -p ${INITRDIMG}
runlog mount ${LOOPDEV} ${INITRDIMG}
cd ${INITRDROOT}
# cpio is best for this kinda thing
echo -n ">>> Copying files"
find . -print0 | cpio -p -0dm --quiet --dot ${INITRDIMG}
echo
umount ${INITRDIMG}
runlog losetup -d ${LOOPDEV}
echo ">>> Compressing initrd..."
gzip -9 ${AUTODISTDIR}/initrd.img
mv -f ${AUTODISTDIR}/initrd.img.gz ${AUTODISTDIR}/initrd.img

echo ">>> Creating usr.img..."
usrsize=`du -sk ${AUTODISTDIR}/initrdusr | sed 's,\([0-9]\+\).*,\1,'`
# it doesn't hurt to pad it a bit :)
usrsize=`expr ${usrsize} + 256`
# lets make it an even multiple of INITRD_BSIZE bytes
bsizek=`expr ${INITRD_BSIZE} / 1024`
usrsize=`expr ${usrsize} / ${bsizek}`
usrsize=`expr ${usrsize} + 1`
runlog dd if=/dev/zero of=${AUTODISTDIR}/usr.img bs=${INITRD_BSIZE} count=${usrsize}
mkdir -p ${AUTODISTDIR}/initrdusrimg
runlog losetup ${LOOPDEV} ${AUTODISTDIR}/usr.img
runlog mke2fs ${LOOPDEV}
runlog mount ${LOOPDEV} ${AUTODISTDIR}/initrdusrimg
cd ${AUTODISTDIR}/initrdusr
# cpio is best for this kinda thing
echo -n ">>> Copying files"
find . -print0 | cpio -p -0dm --quiet --dot ${AUTODISTDIR}/initrdusrimg
echo
runlog umount ${AUTODISTDIR}/initrdusrimg
runlog losetup -d ${LOOPDEV}
echo ">>> Compressing usr.img..."
create_compressed_fs ${AUTODISTDIR}/usr.img 65536 > ${AUTODISTDIR}/usr.img.compressed 2>&3
mv ${AUTODISTDIR}/usr.img.compressed ${AUTODISTDIR}/usr.img

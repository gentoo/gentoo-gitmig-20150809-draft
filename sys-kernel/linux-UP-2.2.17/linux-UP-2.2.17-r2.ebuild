# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/linux-UP-2.2.17/linux-UP-2.2.17-r2.ebuild,v 1.2 2000/10/03 16:02:07 achim Exp $

P=linux-UP-2.2.17
A="linux-2.2.17.tar.bz2 i2c-2.5.2.tar.gz lm_sensors-2.5.2.tar.gz
   linux-2.2.17-reiserfs-3.5.26-patch.gz
   ide.2.2.17.all.20000904.patch.bz2
   raid-2.2.17-A0 patch-2.2.16-agpgart.bz2 pppoed0.47.tgz"


S=${WORKDIR}/linux
DESCRIPTION="Linux kernel for UP systems with reiserfs,usb,sensors,raid,udma,nfs3 and pppoe support"
SRC_URI="ftp://ftp.uk.kernel.org/pub/linux/kernel/v2.2/linux-2.2.17.tar.bz2
	 ftp://ftp.de.kernel.org/pub/linux/kernel/v2.2/linux-2.2.17.tar.bz2
  	 http://www.netroedge.com/~lm78/archive/lm_sensors-2.5.2.tar.gz
	 http://www.netroedge.com/~lm78/archive/i2c-2.5.2.tar.gz
	 http://devlinux.com/pub/namesys/linux-2.2.17-reiserfs-3.5.26-patch.gz
	 http://people.redhat.com/mingo/raid-patches/raid-2.2.17-A0
	 http://ishmael.nmh.northfield.ma.us/~zander/nv-agpgart/patch-2.2.16-agpgart.bz2
	 ftp://ftp.kernel.org/pub/linux/kernel/people/hedrick/ide-2.2.17/ide.2.2.17.all.20000904.patch.bz2
	 ftp://ftp.uk.kernel.org/pub/linux/kernel/people/hedrick/ide-2.2.17/ide.2.2.17.all.20000904.patch.bz2
	 ftp://ftp.de.kernel.org/pub/linux/kernel/people/hedrick/ide-2.2.17/ide.2.2.17.all.20000904.patch.bz2
	 http://www.davin.ottawa.on.ca/pppoe/pppoed0.47.tgz"

HOMEPAGE="http://www.kernel.org/
	  http://www.netroedge.com/~lm78/
	  http://devlinux.com/projects/reiserfs/
	  http://www.linux-usb.org/"

	
src_compile() {
    cd ${S}
    unset CFLAGS
    unset CXXFLAGS
    try make dep
    try make bzImage
    try make modules
    cd ${S}/fs/reiserfs/utils
    try make
    cd ${S}/lm_sensors-2.5.2
    try make
}

src_unpack() {
    unpack linux-2.2.17.tar.bz2
    cd ${S}
    echo "Applying UDMA patch..."
    bzip2 -dc ${DISTDIR}/ide.2.2.17.all.20000904.patch.bz2 | patch -p1
    echo "Applying reiserfs-patch..."
    gzip -dc ${DISTDIR}/linux-2.2.17-reiserfs-3.5.26-patch.gz | patch -p1
    echo "Applying reiserfs-knfsd-patch..."
    gzip -dc ${O}/files/reiserfs-3.5.22-knfsd-8.gz | patch -p1
    echo "Applying usb-patch..."
    gzip -dc ${O}/files/usb-2.4.0-test2-pre2-for-2.2.17p6-reiserfs.diff.gz | patch -p1 -N 

    echo "Applying pppoe-patch..."
    unpack pppoed0.47.tgz
    patch -p1 < pppoed-0.47/kernel-patches/2214-pppox
   
    echo "Creating i2c-patch..."
    unpack i2c-2.5.2.tar.gz
    cd i2c-2.5.2
    mkpatch/mkpatch.pl . ${S} > ${S}/i2c-patch
    cd ${S}
    echo "Applying i2c-patch..."
    patch -p1 < i2c-patch

    echo "Creating lm-sensors-patch..."
    unpack lm_sensors-2.5.2.tar.gz
    cd lm_sensors-2.5.2



    mkpatch/mkpatch.pl . ${S} > ${S}/sensors.patch
    cd ${S}
    echo "Applying lm_sensors-patch..."
    patch -p1 < sensors.patch

    echo "Applying raid-patch..."
    patch -p1 < ${DISTDIR}/raid-2.2.17-A0

    echo "Applying agp-patch..."
    bzip2 -dc ${DISTDIR}/patch-2.2.16-agpgart.bz2 | patch -p1

    echo "Prepare for compilation..."
    cd ${S}/arch/i386
#    cp Makefile Makefile.orig
##    sed -e "s/-DCPU=686/-DCPU=586/" -e "s/\-m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=586/${CFLAGS}/" Makefile.orig > Makefile
    cd ${S}
#    cp Makefile Makefile.orig
##    sed -e 's:-O2:${CFLAGS}:g' Makefile.orig > Makefile
    try make include/linux/version.h
    try make symlinks
    cp ${O}/files/${P}-r1.config .config
    cp ${O}/files/${P}-r1.autoconf include/linux/autoconf.h
    cp ${O}/files/gentoolinux_logo.h include/linux/linux_logo.h

    cd ${S}/lm_sensors-2.5.2

    cp Makefile Makefile.orig
    sed -e "s:^LINUX=.*:LINUX=${S}:" \
	-e "s/^COMPILE_KERNEL.*/COMPILE_KERNEL := 0/" \
	-e "s:^I2C_HEADERS.*:I2C_HEADERS=${S}/i2c-2.5.2/kernel:" \
	-e "s/^SMP/#SMP/" \
	-e "s/^#SMP := 0/SMP := 0/" \
	-e "s:^DESTDIR.*:DESTDIR \:= ${D}:" \
	-e "s:^PREFIX \:= .*:PREFIX \:= /usr:" \
	Makefile.orig > Makefile

}

src_install() {                               
    dodir /usr/src/linux
    dodir /usr/src/linux/include/linux
    dodir /usr/src/linux/include/asm-i386
    cp -ax ${S}/include ${D}/usr/src/linux
    dodir /usr/src/linux/Documentation
    cp -ax ${S}/Documentation ${D}/usr/src/linux
    cd ${S}/Documentation
    find . -type f -exec gzip {} \;
    dodir /usr/include
    dosym /usr/src/linux/include/linux /usr/include/linux
    dosym /usr/src/linux/include/asm-i386 /usr/include/asm
    insinto /
    cd ${S}
    doins arch/i386/boot/bzImage
    try make INSTALL_MOD_PATH=${D} modules_install
    dosym /lib/modules/2.2.17pre13-RAID ${D}/lib/modules/current
    into /
    cd ${S}/fs/reiserfs/utils/bin
    dosbin mkreiserfs resize_reiserfs reiserfsck dumpreiserfs
    cd ..
    into /usr
    doman fsck/reiserfsck.8 
    doman mkreiserfs/mkreiserfs.8
    cp dumpreiserfs/README README.dumpreiserfs
    cp README README.reiserfs
    dodoc README.reiserfs README.dumpreiserfs
    cd ${S}/lm_sensors-2.5.2
    try make install
    prepman
}











# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/linux/linux-2.2.18.ebuild,v 1.4 2000/12/29 00:05:20 achim Exp $

P=linux-UP-2.2.18
A="linux-2.2.18.tar.bz2 i2c-2.5.4.tar.gz lm_sensors-2.5.4.tar.gz
   linux-2.2.18-reiserfs-3.5.29-patch.gz
   ide.2.2.18.1221.patch.bz2
   patch-2.2.16-agpgart.bz2 pppoed0.47.tgz lpp-0.1c.tar.bz2"


S=${WORKDIR}/linux
DESCRIPTION="Linux kernel for UP systems with reiserfs,usb,sensors,raid,udma,nfs3 and pppoe support"
SRC_URI="ftp://ftp.uk.kernel.org/pub/linux/kernel/v2.2/linux-2.2.18.tar.bz2
	 ftp://ftp.de.kernel.org/pub/linux/kernel/v2.2/linux-2.2.18.tar.bz2
  	 http://www.netroedge.com/~lm78/archive/lm_sensors-2.5.4.tar.gz
	 http://www.netroedge.com/~lm78/archive/i2c-2.5.4.tar.gz
	 ftp://ftp.reiserfs.org/pub/linux-2.2.18-reiserfs-3.5.29-patch.gz
	 ftp://ftp.kernel.org/pub/linux/kernel/people/hedrick/ide-2.2.18/ide.2.2.18.1221.patch.bz2
	 ftp://ftp.uk.kernel.org/pub/linux/kernel/people/hedrick/ide-2.2.18/ide.2.2.18.1221.patch.bz2
	 ftp://ftp.de.kernel.org/pub/linux/kernel/people/hedrick/ide-2.2.18/ide.2.2.18.1221.patch.bz2
	 http://www.davin.ottawa.on.ca/pppoe/pppoed0.47.tgz
	 http://lug.mfh-iserlohn.de/lpp/lpp-0.1c.tar.bz2"

HOMEPAGE="http://www.kernel.org/
	  http://www.netroedge.com/~lm78/
	  http://devlinux.com/projects/reiserfs/
	  http://www.linux-usb.org
	  http://www.atnf.csiro.au/~rgooch/linux/kernel-patches.html"
DEPEND=""
RDEPEND=""
	
src_compile() {
    cd ${S}
    unset CFLAGS
    unset CXXFLAGS
    try make dep
    cd ${S}/arch/i386/lib
    cp Makefile Makefile.orig
    sed -e "s:-traditional::" Makefile.orig > Makefile
    cd ${S}
    try make bzImage
    try make modules
    cd ${S}/fs/reiserfs/utils
    try make
    cd ${S}/lm_sensors-2.5.4
    try make
}

src_unpack() {

    unpack linux-2.2.18.tar.bz2

    cd ${S}

    echo "Applying UDMA patch..."
    bzip2 -dc ${DISTDIR}/ide.2.2.18.1221.patch.bz2 | patch -p1

    echo "Applying reiserfs-patch..."
    gzip -dc ${DISTDIR}/linux-2.2.18-reiserfs-3.5.29-patch.gz | patch -p1

    echo "Applying pppoe-patch..."
    unpack pppoed0.47.tgz
    patch -p1 < pppoed-0.47/kernel-patches/2214-pppox

    echo "Applying linux-progress-patch..."
    unpack lpp-0.1c.tar.bz2

    bzip2 -dc lpp-0.1c/lpp-2.2.18.bz2 | patch -p1

    echo "Creating i2c-patch..."
    unpack i2c-2.5.4.tar.gz
    cd i2c-2.5.4
    mkpatch/mkpatch.pl . ${S} > ${S}/i2c-patch
    cd ${S}
    echo "Applying i2c-patch..."
    patch -p1 < i2c-patch

    echo "Creating lm-sensors-patch..."
    unpack lm_sensors-2.5.4.tar.gz
    cd lm_sensors-2.5.4
    mkpatch/mkpatch.pl . ${S} > ${S}/sensors.patch
    cd ${S}
    echo "Applying lm_sensors-patch..."
    patch -p1 < sensors.patch


    echo "Prepare for compilation..."
    cd ${S}/arch/i386
#    cp Makefile Makefile.orig
##    sed -e "s/-DCPU=686/-DCPU=586/" -e "s/\-m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=586/${CFLAGS}/" Makefile.orig > Makefile
    cd ${S}
#    cp Makefile Makefile.orig
##    sed -e 's:-O2:${CFLAGS}:g' Makefile.orig > Makefile
    try make include/linux/version.h
    try make symlinks
    cp ${O}/files/${PV}/${PF}.config .config
    cp ${O}/files/${PV}/${PF}.autoconf include/linux/autoconf.h
    cp ${O}/files/${PV}/gentoolinux_logo.h include/linux/linux_logo.h

    cd ${S}/lm_sensors-2.5.4

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

src_compile() {
    cd ${S}
    unset CFLAGS
    unset CXXFLAGS
    try make dep
    cd ${S}/arch/i386/lib
    cp Makefile Makefile.orig
    sed -e "s:-traditional::" Makefile.orig > Makefile
    cd ${S}
    try make bzImage
    try make modules
    cd ${S}/fs/reiserfs/utils
    try make
    cd ${S}/lm_sensors-2.5.4
    try make
}

src_install() {                               

    dodir /usr/src/${PF}
    dodir /usr/src/${PF}/include/linux
    dodir /usr/src/${PF}/include/asm-i386
    cp -ax ${S}/include ${D}/usr/src/${PF}
    dodir /usr/src/${PF}/Documentation
    cp -ax ${S}/Documentation ${D}/usr/src/${PF}
    cd ${S}/Documentation
    find . -type f -exec gzip {} \;
    dodir /usr/include
    dosym /usr/src/${PF} /usr/src/linux-2.2
    dosym /usr/src/${PF} /usr/src/linux
    dosym /usr/src/${PF}/include/linux /usr/include/linux
    dosym /usr/src/${PF}/include/asm-i386 /usr/include/asm
    insinto /
    cd ${S}
    doins arch/i386/boot/bzImage
    try make INSTALL_MOD_PATH=${D} modules_install
    cd ${D}/lib/modules
    ln -sf 2.2.18-RAID current
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
    cd ${S}/lm_sensors-2.5.4
    try make install
    preplib /usr
}

















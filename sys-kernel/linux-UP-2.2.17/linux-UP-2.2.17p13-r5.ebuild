# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/linux-UP-2.2.17/linux-UP-2.2.17p13-r5.ebuild,v 1.2 2000/08/16 04:38:34 drobbins Exp $

P=linux-UP-2.2.17p13
A="linux-2.2.16.tar.bz2 i2c-2.5.2.tar.gz lm_sensors-2.5.2.tar.gz
   linux-2.2.16-reiserfs-3.5.23-patch.gz pre-patch-2.2.17-13.bz2
   ide.2.2.17pre13.all.20000722.patch.bz2 reiserfs-3.5.22-knfsd-7.gz 
   raid-2.2.17-A0 patch-2.2.16-agpgart.bz2 pppoed0.47.tgz"

S=${WORKDIR}/linux
DESCRIPTION="Linux kernel for UP systems with reiserfs,usb,sensors,raid,udma and pppoe support"
SRC_URI="ftp://ftp.uk.kernel.org/pub/linux/kernel/v2.2/linux-2.2.16.tar.bz2
	 ftp://ftp.de.kernel.org/pub/linux/kernel/v2.2/linux-2.2.16.tar.bz2
	 ftp://ftp.kernel.org/pub/linux/kernel/people/alan/2.2.17pre/pre-patch-2.2.17-13.bz2
	 http://www.netroedge.com/~lm78/archive/lm_sensors-2.5.2.tar.gz
	 http://www.netroedge.com/~lm78/archive/i2c-2.5.2.tar.gz
	 http://devlinux.com/pub/namesys/linux-2.2.16-reiserfs-3.5.23-patch.gz
	 ftp://ftp.suse.com/pub/people/ak/nfs/reiserfs-3.5.22-knfsd-7.gz
	 http://people.redhat.com/mingo/raid-patches/raid-2.2.17-A0
	 http://ishmael.nmh.northfield.ma.us/~zander/nv-agpgart/patch-2.2.16-agpgart.bz2
	 http://republika.pl/bkz/ide.2.2.17pre13.all.20000722.patch.bz2
	 http://www.davin.ottawa.on.ca/pppoe/pppoed0.47.tgz"

HOMEPAGE="http://www.kernel.org/
	  http://www.netroedge.com/~lm78/
	  http://devlinux.com/projects/reiserfs/
	  http://www.linux-usb.org/"

	
src_compile() {
    cd ${S}
    unset CFLAGS
    unset CXXFLAGS
    make dep
    make bzImage
    make modules
    cd ${S}/fs/reiserfs/utils
    make
    cd ${S}/lm_sensors-2.5.2
    make
}

src_unpack() {
    unpack linux-2.2.16.tar.bz2
    cd ${S}
#    unpack ${A5}
    echo "Applying pre13-patch..."
    bzip2 -dc ${DISTDIR}/pre-patch-2.2.17-13.bz2 | patch -p1
    echo "Applying UDMA patch..."
    bzip2 -dc ${DISTDIR}/ide.2.2.17pre13.all.20000722.patch.bz2 | patch -p1
    echo "Applying reiserfs-patch..."
    gzip -dc ${DISTDIR}/linux-2.2.16-reiserfs-3.5.23-patch.gz | patch -p1
    echo "Applying reiserfs-knfsd-patch..."
    gzip -dc ${DISTDIR}/reiserfs-3.5.22-knfsd-7.gz | patch -p1
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

    echo "Applying reiserfsck-segfault patch..."
    patch -p1 < ${O}/files/free_thrown.diff

    echo "Applying raid-patch..."
    patch -p2 < ${DISTDIR}/raid-2.2.17-A0

    echo "Applying agp-patch..."
    bzip2 -dc ${DISTDIR}/patch-2.2.16-agpgart.bz2 | patch -p1

    echo "Prepare for compilation..."
    cd ${S}/arch/i386
#    cp Makefile Makefile.orig
##    sed -e "s/-DCPU=686/-DCPU=586/" -e "s/\-m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=586/${CFLAGS}/" Makefile.orig > Makefile
    cd ${S}
#    cp Makefile Makefile.orig
##    sed -e 's:-O2:${CFLAGS}:g' Makefile.orig > Makefile
    make include/linux/version.h
    make symlinks
    cp ${O}/files/${P}.config .config
    cp ${O}/files/${P}.autoconf include/linux/autoconf.h
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
    make INSTALL_MOD_PATH=${D} modules_install
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
    make install
    prepman
}







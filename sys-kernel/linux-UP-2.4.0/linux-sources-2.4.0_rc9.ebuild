# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/linux-UP-2.4.0/linux-sources-2.4.0_rc9.ebuild,v 1.2 2000/11/02 16:31:56 drobbins Exp $

A="linux-2.4.0-test8.tar.bz2 linux-2.4.0-test8-reiserfs-3.6.16-patch.gz
	ide.2.4.0-t9-6.task.0923.patch.gz test9-pre7.gz
	i2c-2.5.2.tar.gz lm_sensors-2.5.2.tar.gz jfs-0.0.16-patch.tar.gz"
#   pppoed0.47.tgz
#   linux-2.2.17pre13-nfsv3-0.22.3.dif.bz2 kernel-nfs-dhiggen_merge-3.0.tar.gz"

S=${WORKDIR}/linux
DESCRIPTION="Linux kernel sources with jfs,reiserfs,usb,sensors,raid,udma,nfs3 and pppoe support"
SRC_URI="ftp://ftp.uk.kernel.org/pub/linux/kernel/v2.4/linux-2.4.0-test8.tar.bz2
	 ftp://ftp.de.kernel.org/pub/linux/kernel/v2.4/linux-2.4.0-test8.tar.bz2
	 http://devlinux.com/pub/namesys/2.4-beta/linux-2.4.0-test8-reiserfs-3.6.16-patch.gz
	 ftp://ftp.kernel.org/pub/linux/kernel/people/hedrick/ide.2.4.0-t9/ide.2.4.0-t9-6.task.0923.patch.gz
	 ftp://ftp.kernel.org/pub/linux/kernel/testing/test9-pre7.gz
  	 http://www.netroedge.com/~lm78/archive/lm_sensors-2.5.2.tar.gz
	 http://www.netroedge.com/~lm78/archive/i2c-2.5.2.tar.gz
	 http://oss.software.ibm.com/developerworks/opensource/jfs/project/pub/jfs-0.0.16-patch.tar.gz"
#	 http://www.davin.ottawa.on.ca/pppoe/pppoed0.47.tgz

HOMEPAGE="http://www.kernel.org/
	  http://www.netroedge.com/~lm78/
	  http://devlinux.com/projects/reiserfs/"

	
src_compile() {
	try make dep
}

src_unpack() {
    unpack linux-2.4.0-test8.tar.bz2
    cd ${S}
#    unpack ${A5}
    echo "Applying pre7 patch..."
    gzip -dc ${DISTDIR}/test9-pre7.gz | patch -p1
    echo "Applying UDMA patch..."
    gzip -dc ${DISTDIR}/ide.2.4.0-t9-6.task.0923.patch.gz | patch -p1
    echo "Applying reiserfs-patch..."
    gzip -dc ${DISTDIR}/linux-2.4.0-test8-reiserfs-3.6.16-patch.gz | patch -p1
    cd ${S}/fs/reiserfs
    cp dir.c dir.c.orig
    sed -e "s:d_ino):d_ino ,DT_DIR):" dir.c.orig > dir.c

#    echo "Applying pppoe-patch..."
#    unpack pppoed0.47.tgz
#    patch -p1 < pppoed-0.47/kernel-patches/2214-pppox
   
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

	echo "Applying IBM JFS patch..."
	cd ${WORKDIR}
	tar xzvf ${DISTDIR}/jfs-0.0.16-patch.tar.gz
	cd ${S}
	patch -p1 < ../jfs-common-v0.0.16-patch 
	patch -p1 < ../jfs-2.4.0-test9-v0.0.16-patch 
	#fix fs/Makefile problem
	cp ${FILESDIR}/fs/Makefile ${S}/fs/Makefile

    echo "Prepare for compilation..."
#    cd ${S}/arch/i386
#    cp Makefile Makefile.orig
##    sed -e "s/-DCPU=686/-DCPU=586/" -e "s/\-m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=586/${CFLAGS}/" Makefile.orig > Makefile
    cd ${S}
#    cp Makefile Makefile.orig
##    sed -e 's:-O2:${CFLAGS}:g' Makefile.orig > Makefile
	cd ${S}
	try make include/linux/version.h
    try make symlinks
	cd ${S}

#    cp ${O}/files/${P}.config .config
#    cp ${O}/files/${P}.autoconf include/linux/autoconf.h
 
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
	dodir /usr/src
	try mv ${S} ${D}/usr/src/linux-2.4.0-test9
	rm -rf ${WORKDIR}
	cd ${D}/usr/src
	ln -s linux-2.4.0-test9 linux
}











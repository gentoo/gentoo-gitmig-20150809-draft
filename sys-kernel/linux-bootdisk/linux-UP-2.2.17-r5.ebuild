# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/linux-bootdisk/linux-UP-2.2.17-r5.ebuild,v 1.1 2000/12/08 14:12:51 achim Exp $

P=linux-UP-2.2.17
A="linux-2.2.17.tar.bz2
   linux-2.2.17-reiserfs-3.5.28-patch.gz
   ide.2.2.17.all.20001120.patch.bz2 raid-2.2.17-A0"


S=${WORKDIR}/linux
DESCRIPTION="Linux kernel for UP systems with reiserfs,usb,sensors,raid,udma,nfs3 and pppoe support"
SRC_URI="ftp://ftp.uk.kernel.org/pub/linux/kernel/v2.2/linux-2.2.17.tar.bz2
	 ftp://ftp.de.kernel.org/pub/linux/kernel/v2.2/linux-2.2.17.tar.bz2
	 http://devlinux.com/pub/namesys/linux-2.2.17-reiserfs-3.5.28-patch.gz
	 http://people.redhat.com/mingo/raid-patches/raid-2.2.17-A0
	 ftp://ftp.kernel.org/pub/linux/kernel/people/hedrick/ide-2.2.17/ide.2.2.17.all.20001120.patch.bz2
	 ftp://ftp.uk.kernel.org/pub/linux/kernel/people/hedrick/ide-2.2.17/ide.2.2.17.all.20001120.patch.bz2
	 ftp://ftp.de.kernel.org/pub/linux/kernel/people/hedrick/ide-2.2.17/ide.2.2.17.all.20001120.patch.bz2"

HOMEPAGE="http://www.kernel.org/
	  http://devlinux.com/projects/reiserfs/
	  http://www.linux-usb.org"
	


src_unpack() {

    unpack linux-2.2.17.tar.bz2

    cd ${S}

    echo "Applying UDMA patch..."
    bzip2 -dc ${DISTDIR}/ide.2.2.17.all.20001120.patch.bz2 | patch -p1

    echo "Applying reiserfs-patch..."
    gzip -dc ${DISTDIR}/linux-2.2.17-reiserfs-3.5.28-patch.gz | patch -p1

    echo "Applying raid-patch..."
    patch -p1 < ${DISTDIR}/raid-2.2.17-A0

    echo "Prepare for compilation..."
    cd ${S}/arch/i386
    cd ${S}

    try make include/linux/version.h
    try make symlinks
    cp ${O}/files/${PF}.config .config
    cp ${O}/files/${PF}.autoconf include/linux/autoconf.h
    cp ${O}/files/gentoolinux_logo.h include/linux/linux_logo.h

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
    ln -sf 2.2.17-RAID current
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
}

















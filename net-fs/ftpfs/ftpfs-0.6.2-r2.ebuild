# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ryan Tolboom <ryan@gentoo.org>
# /space/gentoo/cvsroot/gentoo-x86/net-fs/ftpfs/ftpfs-0.6.2.ebuild,v 1.1 2001/12/02 14:17:10 ryan Exp

A=${P}-k2.4.tar.gz
S=${WORKDIR}/${P}-k2.4
DESCRIPTION="A filesystem for mounting FTP volumes"
SRC_URI="http://ftp1.sourceforge.net/ftpfs/${A}"
HOMEPAGE="http://ftpfs.sourceforge.net"

DEPEND="virtual/glibc
        virtual/linux-sources"

src_compile() {
	cd ftpfs
	try make
	cd ../ftpmount
  	try make CFLAGS="${CFLAGS}"
}

src_install() {
	mv ftpfs/Makefile ftpfs/Makefile.old
	cat ftpfs/Makefile.old |sed s:"depmod -aq"::g > ftpfs/Makefile
	try make MODULESDIR=${D}/lib/modules/${KVERS} FTPMOUNT=${D}/usr/bin/ftpmount install
	dodoc CHANGELOG
	docinto html
	dodoc docs/*.html
	docinto html/img
	dodoc docs/img/*
}

pkg_postinst() {

	echo "running depmod...."
	try depmod -aq
}

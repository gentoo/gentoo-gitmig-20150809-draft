# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-fs/ftpfs/ftpfs-0.6.2-r2.ebuild,v 1.6 2002/07/11 06:30:46 drobbins Exp $

A=${P}-k2.4.tar.gz
S=${WORKDIR}/${P}-k2.4
DESCRIPTION="A filesystem for mounting FTP volumes"
SRC_URI="http://ftp1.sourceforge.net/ftpfs/${A}"
HOMEPAGE="http://ftpfs.sourceforge.net"
LICENSE="GPL-2"

DEPEND="virtual/glibc
        virtual/linux-sources
        >=sys-apps/portage-1.9.10"

src_compile() {
	check_KV
	cd ftpfs
	try make
	cd ../ftpmount
	try make CFLAGS="${CFLAGS}"
}

src_install() {
	mv ftpfs/Makefile ftpfs/Makefile.old
	cat ftpfs/Makefile.old |sed s:"depmod -aq"::g > ftpfs/Makefile
	try make MODULESDIR=${D}/lib/modules/${KV} FTPMOUNT=${D}/usr/bin/ftpmount install
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

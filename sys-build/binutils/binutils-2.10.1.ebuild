# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-build/binutils/binutils-2.10.1.ebuild,v 1.1 2001/01/25 18:00:26 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Tools necessary to build programs"
SRC_URI="ftp://ftp.gnu.org/gnu/binutils/${A}"

src_compile() {
	try ./configure --prefix=/usr  --host=${CHOST}  \
             --disable-nls
	try make  -e LDFLAGS=-all-static tooldir=/usr ${MAKEOPTS}
}

src_install() {
	try make prefix=${D}/usr tooldir=${D}/usr install
	rm -rf ${D}/usr/man
	
}




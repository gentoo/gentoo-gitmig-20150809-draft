# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-build/textutils/textutils-2.0.10.ebuild,v 1.2 2001/02/15 18:17:32 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}

DESCRIPTION="Standard GNU text utilities"
SRC_URI="ftp://alpha.gnu.org/gnu/fetish/${A}"

src_compile() {
	try ./configure --prefix=/usr --host=${CHOST}  \
	--without-included-regex --disable-nls
	try make ${MAKEOPTS} LDFLAGS=-static
}


src_install() {
	try make prefix=${D}/usr install
	dodir /bin
	dosym /usr/bin/cat /bin/cat
	rm -rf ${D}/usr/lib ${D}/usr/man ${D}/usr/info
}





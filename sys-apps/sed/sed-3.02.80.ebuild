# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/sed/sed-3.02.80.ebuild,v 1.7 2001/01/31 20:49:07 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Super-useful stream editor"
SRC_URI="ftp://alpha.gnu.org/pub/gnu/sed/${A}"
DEPEND="virtual/glibc"

src_compile() {                           
	try ./configure --prefix=/usr --host=${CHOST}
	try make ${MAKEOPTS}
}

src_install() {                               
	into /usr
	doinfo doc/sed.info
	doman doc/sed.1
	into /
	dobin sed/sed
	dodir /usr/bin
	dosym /bin/sed /usr/bin/sed
	dodoc COPYING NEWS README* THANKS TODO AUTHORS BUGS ANNOUNCE
}


# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/tar/tar-1.13.17-r1.ebuild,v 1.3 2000/09/15 20:09:23 drobbins Exp $

P=tar-1.13.17
A=${P}.tar.gz
S=${WORKDIR}/${P}

DESCRIPTION="Use this to try make tarballs :)"
SRC_URI="ftp://alpha.gnu.org/gnu/tar/"${A}

src_compile() {                           
	try ./configure --prefix=/usr --with-catgets --host=${CHOST}
	cp lib/fnmatch.hin lib/fnmatch.h
	try make
	cd ${S}
}

src_install() {                               
	cd ${S}
	try make prefix=${D}/usr install
	prepinfo
	dodoc COPYING NEWS README THANKS AUTHORS
}



# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/tar/tar-1.13.18-r1.ebuild,v 1.2 2001/01/31 20:49:07 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}

DESCRIPTION="Use this to try make tarballs :)"
SRC_URI="ftp://alpha.gnu.org/gnu/tar/"${A}
HOMEPAGE="http://www.gnu.org/software/tar/"
DEPEND="virtual/glibc"

src_compile() {                           
	try ./configure --prefix=/usr --libexecdir=/usr/libexec/misc --host=${CHOST}
	try make ${MAKEOPTS}
}

src_install() {                               
	cd ${S}
	try make DESTDIR=${D} install
	dodir /bin
	mv ${D}/usr/bin/tar ${D}/bin/tar
	dodoc AUTHORS ChangeLog* COPYING NEWS README* PORTS THANKS

	#we're using Schilly's enhanced rmt command included with star
	rm -rf ${D}/usr/libexec/misc
	rm -rf ${D}/usr/libexec
	
}



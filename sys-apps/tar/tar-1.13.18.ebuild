# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/tar/tar-1.13.18.ebuild,v 1.3 2000/12/24 09:55:16 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}

DESCRIPTION="Use this to try make tarballs :)"
SRC_URI="ftp://alpha.gnu.org/gnu/tar/"${A}
HOMEPAGE="http://www.gnu.org/software/tar/"
DEPEND=">=sys-libs/glibc-2.1.3"
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
}



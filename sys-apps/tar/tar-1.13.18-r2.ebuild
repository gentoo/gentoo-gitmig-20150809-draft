# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/tar/tar-1.13.18-r2.ebuild,v 1.2 2001/02/07 19:32:05 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}

DESCRIPTION="Use this to try make tarballs :)"
SRC_URI="ftp://alpha.gnu.org/gnu/tar/"${A}
HOMEPAGE="http://www.gnu.org/software/tar/"

DEPEND="virtual/glibc
        >=sys-devel/gettext-0.10.35-r2"

RDEPEND="virtual/glibc
         sys-apps/star"

src_compile() {

	try ./configure --prefix=/usr --bindir=/bin --libexecdir=/usr/lib/misc --infodir=/usr/share/info --host=${CHOST}
	try make ${MAKEOPTS}
}

src_install() {

	try make DESTDIR=${D} install
	dodoc AUTHORS ChangeLog* COPYING NEWS README* PORTS THANKS

	#we're using Schilly's enhanced rmt command included with star
	rm -rf ${D}/usr/lib

	
}



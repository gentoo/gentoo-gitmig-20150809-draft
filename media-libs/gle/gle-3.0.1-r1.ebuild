# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/gle/gle-3.0.1-r1.ebuild,v 1.2 2001/02/13 14:29:40 achim Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GL extrusion library"
SRC_URI="http://www.linas.org/gle/gle-3.0.1.tar.gz"
HOMEPAGE="http://www.linas.org/gle"

DEPEND="virtual/glibc
        >=media-libs/mesa-2.4
        >=x11-base/xfree-4.0.2"

src_compile() {

	try ./configure --with-x --prefix=/usr
	try make
}

src_install () {
	try make prefix=${D}/usr install
}



# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/gle/gle-3.0.1.ebuild,v 1.1 2001/01/20 19:42:51 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GL extrusion library"
SRC_URI="http://www.linas.org/gle/gle-3.0.1.tar.gz"
HOMEPAGE="http://www.linas.org/gle"

DEPEND=">=sys-libs/glibc-2.1.3 >=x11-base/xfree-4.0.1 >=media-libs/glut-3.7-r1"

src_compile() {
    cd ${S}
	try ./configure --with-x --prefix=/usr/X11R6
	try make
}

src_install () {
	try make prefix=${D}/usr/X11R6 install
}

pkg_postinst() {
	/usr/sbin/env-update
}


# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/x11-libs/fltk/fltk-1.0.10.ebuild,v 1.1 2000/12/11 18:05:42 achim Exp $

S=${WORKDIR}/${P}
DESCRIPTION="C++ user interface toolkit for X and OpenGL."
SRC_URI="ftp://ftp.fltk.org/pub/fltk/${PV}/${P}-source.tar.bz2"
HOMEPAGE="http://www.fltk.org"
DEPEND=">=x11-base/xfree-4.0.1
	>=media-libs/mesa-3.4"


src_compile() {

    cd ${S}
    try ./configure --prefix=/usr/X11R6 --host=${CHOST} --enable-shared
    try make

}

src_install () {

    cd ${S}
    try make prefix=${D}/usr/X11R6 install
    dodoc CHANGES COPYING README*
    mv ${D}/usr/X11R6/share/doc/fltk ${D}/usr/doc/${PF}/html

}


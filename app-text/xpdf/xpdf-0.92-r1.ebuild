# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ryan Tolboom <ryan@intphsys.com>
# $Header: /var/cvsroot/gentoo-x86/app-text/xpdf/xpdf-0.92-r1.ebuild,v 1.2 2001/03/20 07:08:01 achim Exp $

S=${WORKDIR}/${P}

SRC_URI="ftp://ftp.foolabs.com/pub/xpdf/${P}.tgz"

HOMEPAGE="http://www.foolabs.com/xpdf/xpdf.html"

DESCRIPTION="An X Viewer for PDF Files"

DEPEND=">=x11-base/xfree-4.0.2
	>=media-libs/freetype-1.3
	>=media-libs/t1lib-1.0.1"

src_compile() {

    try ./configure --prefix=/usr/X11R6 --mandir=/usr/X11R6/share/man \
	--with-gzip 
    try make

}


src_install() {

    try make DESTDIR=${D} install
    dodoc README ANNOUNCE CHANGES

}

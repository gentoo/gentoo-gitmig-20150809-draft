# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ryan Tolboom <ryan@intphsys.com>
# $Header: /var/cvsroot/gentoo-x86/app-text/xpdf/xpdf-0.92.ebuild,v 1.1 2001/02/09 08:17:00 achim Exp $

S=${WORKDIR}/xpdf-0.92
SRC_URI="ftp://ftp.foolabs.com/pub/xpdf/xpdf-0.92.tgz"

HOMEPAGE="http://www.foolabs.com/xpdf/xpdf.html"

DESCRIPTION="An X Viewer for PDF Files"

DEPEND=">=x11-base/xfree-4.0.1"

src_compile() {

    try ./configure --prefix=/usr/X11R6
    try make

}


src_install() {

    try make DESTDIR=${D} install
    dodoc README ANNOUNCE CHANGES

}

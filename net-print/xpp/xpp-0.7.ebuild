# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/net-print/xpp/xpp-0.7.ebuild,v 1.2 2000/12/17 20:09:02 achim Exp $

S=${WORKDIR}/${P}
DESCRIPTION="X Printing Panel"
SRC_URI="ftp://cups.sourceforge.net/pub/cups/xpp/${P}.tar.gz"
HOMEPAGE="http://cups.sourceforge.net/xpp/"

DEPEND=">=net-print/cups-1.1.4
	 >=x11-libs/fltk-1.0.10"

src_compile() {

    cd ${S}
    try ./configure --prefix=/usr/X11R6 --host=${CHOST}
    try make

}

src_install () {

    cd ${S}
    try make DESTDIR=${D} install
    dodoc LICENSE ChangeLog README
}


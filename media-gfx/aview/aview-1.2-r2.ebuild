# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/aview/aview-1.2-r2.ebuild,v 1.1 2000/11/21 11:06:17 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="An ASCII PNG-Viewer"
SRC_URI="ftp://ftp.ta.jcu.cz/pub/aa/${A}"
HOMEPAGE="http://www.ta.jcu.cz/aa"

DEPEND=">=media-libs/aalib-1.2"

src_compile() {

    cd ${S}
    try ./configure --prefix=/usr --host=${CHOST}
    try make aview

}

src_install () {

    cd ${S}
    into /usr/bin
    dobin aview
    dodoc ANNOUNCE COPYING ChangeLog README* TODO

}



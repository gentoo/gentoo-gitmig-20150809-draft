# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-print/qtcups/qtcups-1.1.ebuild,v 1.3 2000/12/11 17:16:15 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="QT Frontend for the Common UNIX printing system"
SRC_URI="ftp://cups.sourceforge.net/pub/cups/qtcups/${A}"
HOMEPAGE="http://cups.sourceforge.net"

DEPEND=">=x11-libs/qt-x11-2.2.2
	>=net-print/cups-1.1.4"

src_compile() {

    cd ${S}
    try ./configure --prefix=/usr/X11R6 --host=${CHOST} --enable-qt2
    try make

}

src_install () {

    cd ${S}
    try make DESTDIR=${D} install

}


# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/net-print/kups/kups-0.8.0.ebuild,v 1.1 2000/12/11 15:43:00 achim Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A CUPS frint-end for KDE"
SRC_URI="ftp://cups.sourceforge.net/pub/cups/kups/${P}.tar.gz"
HOMEPAGE="http://cups.sourceforge.net/kups/"

DEPEND=">=kde-base/kdelibs-2.0
	>=net-print/qtcups-1.1"

src_compile() {

    cd ${S}
    try ./configure --prefix=/opt/kde2 --host=${CHOST}
    try make

}

src_install () {

    cd ${S}
    try make DESTDIR=${D} install
    dodoc AUTHORS ChangeLog COPYING NEWS README TODO
}


# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/net-print/kups/kups-1.0.ebuild,v 1.1 2001/01/27 10:19:57 achim Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A CUPS front-end for KDE"
SRC_URI="ftp://cups.sourceforge.net/pub/cups/kups/${P}.tar.gz"
HOMEPAGE="http://cups.sourceforge.net/kups/"

DEPEND=">=kde-base/kdelibs-2.0.1
	>=net-print/qtcups-2.0"

src_compile() {

    cd ${S}
    rm configure
    try autoconf
    try CFLAGS=\"${CFLAGS} -L/usr/X11R6/lib\" ./configure --prefix=/opt/kde2 --host=${CHOST}
    try make

}

src_install () {

    cd ${S}
    try make DESTDIR=${D} CUPS_MODEL_DIR=/usr/share/cups/model install
    dodoc AUTHORS ChangeLog COPYING NEWS README TODO
}


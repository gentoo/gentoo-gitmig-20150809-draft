# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/net-print/kups/kups-1.0.ebuild,v 1.3 2001/06/07 21:10:33 achim Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A CUPS front-end for KDE"
SRC_URI="ftp://cups.sourceforge.net/pub/cups/kups/${P}.tar.gz"
HOMEPAGE="http://cups.sourceforge.net/kups/"

DEPEND=">=kde-base/kdelibs-2.1.1 sys-devel/autoconf
	>=net-print/qtcups-2.0"
RDEPEND=">=kde-base/kdelibs-2.1.1
	>=net-print/qtcups-2.0"

src_compile() {

    rm configure
    try autoconf
    try CFLAGS=\"${CFLAGS} -L/usr/X11R6/lib\" ./configure --prefix=${KDEDIR} --host=${CHOST}
    try make

}

src_install () {

    try make DESTDIR=${D} CUPS_MODEL_DIR=/usr/share/cups/model install
    dodoc AUTHORS ChangeLog COPYING NEWS README TODO
}


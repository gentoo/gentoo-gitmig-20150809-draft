# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-print/kups/kups-1.0.ebuild,v 1.7 2002/08/01 11:59:03 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A CUPS front-end for KDE"
SRC_URI="ftp://cups.sourceforge.net/pub/cups/kups/${P}.tar.gz"
HOMEPAGE="http://cups.sourceforge.net/kups/"
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=kde-base/kdelibs-2.1.1 sys-devel/autoconf
	>=net-print/qtcups-2.0"
RDEPEND=">=kde-base/kdelibs-2.1.1
	>=net-print/qtcups-2.0"

src_compile() {
    rm configure
    try autoconf
    try CFLAGS="${CFLAGS} -L/usr/X11R6/lib" ./configure --prefix=${KDEDIR} --host=${CHOST}
    try make
}

src_install () {
    try make DESTDIR=${D} CUPS_MODEL_DIR=/usr/share/cups/model install
    dodoc AUTHORS ChangeLog COPYING NEWS README TODO
}


# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/qtcups/qtcups-2.0-r1.ebuild,v 1.10 2003/09/11 01:40:45 msterret Exp $

S=${WORKDIR}/${P}
DESCRIPTION="QT Frontend for the Common UNIX printing system"
SRC_URI="ftp://cups.sourceforge.net/pub/cups/qtcups/${P}.tar.gz"
HOMEPAGE="http://cups.sourceforge.net"
KEYWORDS="x86 ppc"
SLOT="0"
LICENSE="GPL-2"

DEPEND="=x11-libs/qt-2*
	>=net-print/cups-1.1.4"

src_compile() {

	cd ${S}
	./configure --prefix=/usr --host=${CHOST} --with-qt-dir=/usr/qt/2 || die
	make || die

}

src_install () {

	cd ${S}
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog README TODO

}

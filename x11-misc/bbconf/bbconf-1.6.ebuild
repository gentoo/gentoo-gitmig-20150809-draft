# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/bbconf/bbconf-1.6.ebuild,v 1.8 2002/10/04 06:41:43 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="All-in-one blackbox configuration tool."
SRC_URI="http://${PN}.sourceforge.net/code/${P}.tar.gz"
HOMEPAGE="http://bbconf.sourceforge.net"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 -ppc sparc sparc64"

DEPEND="virtual/x11
	>=x11-libs/qt-3.0.3"

src_compile () {
	./configure --prefix=/usr --host=${CHOST} --with-qt-dir=/usr/qt/3 || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
}

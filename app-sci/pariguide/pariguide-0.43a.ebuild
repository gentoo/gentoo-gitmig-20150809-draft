# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/pariguide/pariguide-0.43a.ebuild,v 1.2 2002/12/18 14:44:51 vapier Exp $

DESCRIPTION="PariGUIde, a GUI for the math. program Pari-GP"
HOMEPAGE="http://www.skalatan.de/pariguide/"
SRC_URI="mirror://sourceforge/pariguide/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=x11-libs/qt-2.2.0
	virtual/x11"
RDEPEND=">=app-sci/pari-2.1.0"

src_compile() {
	econf
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	#weiderly make install does not make the main binary executable
	chmod a+x ${D}/usr/bin/pariguide

	#make install does not honor docdir seting, have to move things manually
	dodoc AUTHORS COPYING README TODO
	mv ${D}/usr/doc/${PN}/html ${D}/usr/share/doc/${PF}
	rm -rf ${D}/usr/doc/
}

# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/pariguide/pariguide-0.43a.ebuild,v 1.1 2002/12/15 23:07:28 george Exp $

IUSE=""

DESCRIPTION="PariGUIde, a GUI for the math. program Pari-GP"
HOMEPAGE="http://www.skalatan.de/pariguide/"
SRC_URI="ftp://ftp.sourceforge.net/pub/sourceforge/pariguide/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=qt-2.2.0
		virtual/x11"

RDEPEND=">=pari-2.1.0"

S="${WORKDIR}/${P}"

src_compile() {
	#./configure \
	#	--host=${CHOST} \
	econf || die "configure failed"
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

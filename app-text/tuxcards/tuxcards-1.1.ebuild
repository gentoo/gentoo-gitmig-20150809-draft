# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/tuxcards/tuxcards-1.1.ebuild,v 1.1 2004/10/18 23:25:42 ticho Exp $

DESCRIPTION="A heirarchical text editor"
HOMEPAGE="http://www.tuxcards.de"

SRC_URI="http://www.tifskom.de/tux/1.1/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86"
IUSE=""
DEPEND=">=qt-3.1.1"

src_compile() {
	sed -e 's:/usr/local:/usr:g' \
		-e 's:/usr/doc/tuxcards:/usr/share/tuxcards:g' tuxcards.pro > tuxpro && \
		mv tuxpro tuxcards.pro
	sed -e 's:/usr/local/doc:/usr/share:g' src/tuxcardsconfiguration.cpp > temp && \
		mv temp src/tuxcardsconfiguration.cpp
	qmake tuxcards.pro

	emake || die
}

src_install() {
	make INSTALL_ROOT=${D} install || die

	dodoc AUTHORS COPYING INSTALL README
}

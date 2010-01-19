# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/tuxcards/tuxcards-2.2.ebuild,v 1.5 2010/01/19 18:58:20 armin76 Exp $

EAPI=2
inherit eutils qt4

DESCRIPTION="A hierarchical notebook"
HOMEPAGE="http://www.tuxcards.de/"
SRC_URI="http://www.tuxcards.de/src/${P}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

DEPEND="x11-libs/qt-gui:4"

S=${WORKDIR}/${PN}

src_configure() {
	eqmake4
}

src_install() {
	dobin ${PN} || die
	newicon src/icons/lo32-app-tuxcards.png ${PN}.png
	make_desktop_entry ${PN} TuxCards ${PN} "Qt;Utility"
	dodoc AUTHORS README
}

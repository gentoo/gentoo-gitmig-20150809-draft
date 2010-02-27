# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/cutemaze/cutemaze-1.1.0.ebuild,v 1.2 2010/02/27 16:07:52 phajdan.jr Exp $

EAPI=2
inherit eutils qt4 games

DESCRIPTION="A simple, top-down game in which mazes are randomly generated"
HOMEPAGE="http://gottcode.org/cutemaze/"
SRC_URI="http://gottcode.org/${PN}/${P}-src.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND="x11-libs/qt-gui:4
	x11-libs/qt-svg:4"

src_configure() {
	eqmake4
}

src_install() {
	dogamesbin ${PN} || die
	dodoc ChangeLog README
	doicon icons/${PN}.png
	domenu icons/${PN}.desktop
	prepgamesdirs
}

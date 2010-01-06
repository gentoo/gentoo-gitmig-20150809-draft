# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/connectagram/connectagram-1.0.1.ebuild,v 1.1 2010/01/06 00:44:22 ssuominen Exp $

EAPI=2
inherit eutils qt4 games

DESCRIPTION="A word unscrambling game"
HOMEPAGE="http://gottcode.org/connectagram/"
SRC_URI="http://gottcode.org/${PN}/${P}-src.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/qt-gui:4"

src_configure() {
	eqmake4
}

src_install() {
	dogamesbin bin/${PN} || die
	dodoc ChangeLog
	doicon icons/${PN}.png
	domenu icons/${PN}.desktop
	prepgamesdirs
}

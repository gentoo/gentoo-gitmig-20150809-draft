# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/mahjongg3d/mahjongg3d-0.95.ebuild,v 1.3 2004/11/30 21:54:09 swegener Exp $

inherit kde games

DESCRIPTION="An implementation of the classical chinese game Mah Jongg with 3D OpenGL graphics"
HOMEPAGE="http://www.reto-schoelly.de/mahjongg3d/"
# No version upstream
#SRC_URI="http://www.reto-schoelly.de/${PN}/${PN}.tar.bz2"
SRC_URI="mirror:/gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND=">=x11-libs/qt-3.2.0
	virtual/opengl"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

S="${WORKDIR}/${PN}.release"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e "/GAMEDATA_BASE_PATH/ s:\.:${GAMES_DATADIR}/${PN}:" \
		src/gamedata_path.h || die "sed src/gamedata_path.h failed"
}

src_compile() {
	qmake -o Makefile mahjongg3d.pro
	kde_src_compile none
	emake || die "emake failed"
}

src_install () {
	dogamesbin bin/{mahjongg3d,mahjongg3d-install-*} || die "dogamesbin failed"
	dodir "${GAMES_DATADIR}/${PN}"
	cp -r bin/{[a-l]*,t*} "${D}${GAMES_DATADIR}/${PN}" || die "cp failed"
	dodoc README Changelog
	prepgamesdirs
}

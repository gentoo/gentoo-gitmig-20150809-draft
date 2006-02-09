# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/mahjongg3d/mahjongg3d-0.96.ebuild,v 1.7 2006/02/09 13:55:10 caleb Exp $

inherit kde games

DESCRIPTION="An implementation of the classical chinese game Mah Jongg with 3D OpenGL graphics"
HOMEPAGE="http://www.reto-schoelly.de/mahjongg3d/"
SRC_URI="http://www.reto-schoelly.de/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="$(qt_min_version 3.2)
	virtual/opengl"

S=${WORKDIR}/${PN}.release

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "/GAMEDATA_BASE_PATH/ s:\.:${GAMES_DATADIR}/${PN}:" \
		src/gamedata_path.h \
		|| die "sed failed"
}

src_compile() {
	qmake QMAKE=${QTDIR}/bin/qmake -o Makefile mahjongg3d.pro
	kde_src_compile none
	emake || die "emake failed"
}

src_install () {
	dogamesbin bin/mahjongg3d || die "dogamesbin failed"
	dodir "${GAMES_DATADIR}/${PN}"
	cp -r bin/{[a-l]*,t*} "${D}${GAMES_DATADIR}/${PN}" || die "cp failed"
	dodoc README Changelog
	prepgamesdirs
}

# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/mahjongg3d/mahjongg3d-0.96.ebuild,v 1.9 2007/11/23 18:54:11 mr_bones_ Exp $

inherit eutils qt3 kde games

DESCRIPTION="An implementation of the classical chinese game Mah Jongg with 3D OpenGL graphics"
HOMEPAGE="http://www.reto-schoelly.de/mahjongg3d/"
SRC_URI="http://www.reto-schoelly.de/${PN}/${P}.tar.bz2
	http://www.reto-schoelly.de/mahjongg3d/${P}-patch2.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="$(qt_min_version 3.2)
	virtual/opengl"

S=${WORKDIR}/${PN}.release

src_unpack() {
	unpack ${P}.tar.bz2
	cd "${S}"
	unpack ${P}-patch2.tar.bz2
	sed -i \
		-e "/GAMEDATA_BASE_PATH/ s:\.:${GAMES_DATADIR}/${PN}:" \
		src/gamedata_path.h \
		|| die "sed failed"
	#bug #135885
	sed -i \
		-e 's/openglwidget.h/OpenGLWidget.h/' src/MainDialogBase.ui \
		|| die "sed failed"
}

src_compile() {
	eqmake3 mahjongg3d.pro
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

# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/neverball/neverball-1.3.6.ebuild,v 1.1 2004/07/26 07:02:08 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="Clone of Super Monkey Ball using SDL/OpenGL"
HOMEPAGE="http://icculus.org/neverball/"
SRC_URI="http://icculus.org/neverball/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc amd64"
IUSE=""

RDEPEND=">=media-libs/libsdl-1.2
	>=media-libs/sdl-mixer-1.2.5
	>=media-libs/sdl-image-1.2.2
	media-libs/sdl-ttf
	virtual/opengl
	virtual/glut"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e '/CONFIG_DATA/s:"\./data":"'${GAMES_DATADIR}/${PN}'":g' \
		share/config.h \
		|| die "sed config.h failed"
	sed -i \
		-e 's:-O3:$(E_CFLAGS):' \
		Makefile \
		|| die "sed Makefile failed"
}

src_compile() {
	emake E_CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	dogamesbin neverball neverputt || die "dogamesbin failed"
	newgamesbin mapc ${PN}-mapc || die "newgamesbin failed"

	rm -f data/Makefile*
	dodir "${GAMES_DATADIR}/${PN}"
	cp -R "${S}/data/"* "${D}/${GAMES_DATADIR}/${PN}/" || die

	dodoc CHANGES README
	prepgamesdirs
}

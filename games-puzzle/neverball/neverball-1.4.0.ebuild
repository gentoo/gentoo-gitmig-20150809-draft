# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/neverball/neverball-1.4.0.ebuild,v 1.1 2004/09/16 09:39:49 mr_bones_ Exp $

inherit games

DESCRIPTION="Clone of Super Monkey Ball using SDL/OpenGL"
HOMEPAGE="http://icculus.org/neverball/"
SRC_URI="http://icculus.org/neverball/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc amd64"
IUSE=""

DEPEND=">=media-libs/libsdl-1.2
	>=media-libs/sdl-mixer-1.2.5
	>=media-libs/sdl-image-1.2.2
	media-libs/sdl-ttf
	virtual/opengl"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e '/CONFIG_DATA/s:"\./data":"'${GAMES_DATADIR}/${PN}'":g' \
		share/config.h \
		|| die "sed config.h failed"
	sed -i \
		-e 's:-O3:$(E_CFLAGS):' \
		-e "/^MAPC_TARG/s/mapc/${PN}-mapc/" \
		Makefile \
		|| die "sed Makefile failed"
	find data/ -type f -exec chmod a-x \{\} \;
}

src_compile() {
	emake E_CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	dogamesbin ${PN}-mapc neverball neverputt || die "dogamesbin failed"
	dodir "${GAMES_DATADIR}/${PN}"
	cp -R data/* "${D}/${GAMES_DATADIR}/${PN}/" || die "cp failed"
	dodoc CHANGES README
	prepgamesdirs
}

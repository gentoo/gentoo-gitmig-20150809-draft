# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/neverball/neverball-1.2.1.ebuild,v 1.3 2004/04/11 17:44:12 vapier Exp $

inherit games eutils

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
	virtual/glut"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i '/CONFIG_PATH/s:"\./data":"'${GAMES_DATADIR}/${PN}'":g' \
		share/config.h \
		|| die "sed config.h failed"
	sed -i "s:-Wall -O3:${CFLAGS}:" \
		Makefile \
		|| die "sed Makefile failed"
}

src_install() {
	dogamesbin neverball neverputt || die

	rm -f data/Makefile*
	dodir ${GAMES_DATADIR}/${PN}
	cp -R ${S}/data/* ${D}/${GAMES_DATADIR}/${PN}/ || die

	dodoc CHANGES MAPPING README
	prepgamesdirs
}

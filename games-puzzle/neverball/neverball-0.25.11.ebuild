# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/neverball/neverball-0.25.11.ebuild,v 1.4 2004/02/03 21:29:04 mr_bones_ Exp $

inherit eutils games

DATA="${GAMES_DATADIR}/${PN}/data"
DESCRIPTION="Clone of Super Monkey Ball using SDL/OpenGL"
HOMEPAGE="http://icculus.org/neverball/"
SRC_URI="http://icculus.org/neverball/${P}.tar.bz2"

KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"
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
	epatch ${FILESDIR}/${PV}-gcc2.patch
	sed -i "/CONFIG_PATH/s:\"./data\":\"${DATA}\":g" config.h || \
		die "sed config.h failed"
	sed -i \
		-e "s:-Wall -g:${CFLAGS}:" \
		-e "s:^include:-include:" Makefile || \
			die "sed Makefile failed"
}

src_install() {
	dogamesbin neverball

	rm -f data/Makefile*
	dodir ${DATA}
	cp -R ${S}/data/* ${D}/${DATA}/

	dodoc CHANGES MAPPING README
	prepgamesdirs
}

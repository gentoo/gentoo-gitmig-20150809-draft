# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/neverputt/neverputt-0.18.3.ebuild,v 1.2 2004/02/10 06:12:44 mr_bones_ Exp $

inherit games

DATA="${GAMES_DATADIR}/${PN}/data"
DESCRIPTION="Mini golf game forked from the neverball code"
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
	sed -i "/CONFIG_PATH/s:\"./data\":\"${DATA}\":g" config.h || \
		die "sed config.h failed"
	sed -i \
		-e "s:-Wall -g:${CFLAGS}:" \
		-e "s:^include:-include:" Makefile || \
			die "sed Makefile failed"
}

src_install() {
	rm -f data/Makefile*
	dogamesbin neverputt            || die "dogamesbin failed"
	dodir ${DATA}                   || die "dodir failed"
	cp -R ${S}/data/* ${D}/${DATA}/ || die "cp failed"
	dodoc CHANGES MAPPING README    || die "dodoc failed"
	prepgamesdirs
}

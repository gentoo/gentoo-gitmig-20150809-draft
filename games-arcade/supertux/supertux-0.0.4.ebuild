# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/supertux/supertux-0.0.4.ebuild,v 1.1 2003/09/12 01:52:45 msterret Exp $

inherit games

DESCRIPTION="A game similar to Super Mario Bros."
SRC_URI="ftp://ftp.sonic.net/pub/users/nbs/unix/x/supertux/src/${P}.tar.gz"
HOMEPAGE="http://www.newbreedsoftware.com/supertux/"

KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"

RDEPEND=">=media-libs/libsdl-1.1.5
	>=media-libs/sdl-image-1.2.2
	>=media-libs/sdl-mixer-1.2.4"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i \
		-e "/^DATA_PREFIX=/ s:=.*:=${GAMES_DATADIR}/${PN}/:" \
		-e "/^JOY=/ s/YES/NO/" \
		-e "s:-O2:${CFLAGS}:" Makefile || \
			die "sed Makefile failed"

	rm -rf data/images/shared/.xvpics
}

src_install() {
	dogamesbin supertux
	dodir ${GAMES_DATADIR}/${PN}
	cp -r data/{images,sounds,music,levels} ${D}/${GAMES_DATADIR}/${PN}/
	dodoc {AUTHORS,CHANGES,INSTALL,README,TODO}.txt
	prepgamesdirs
}

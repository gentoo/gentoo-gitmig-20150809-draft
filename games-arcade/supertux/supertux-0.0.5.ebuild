# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/supertux/supertux-0.0.5.ebuild,v 1.1 2004/01/01 01:31:06 mr_bones_ Exp $

inherit games

DESCRIPTION="A game similar to Super Mario Bros."
HOMEPAGE="http://www.newbreedsoftware.com/supertux/"
SRC_URI="ftp://ftp.sonic.net/pub/users/nbs/unix/x/supertux/src/${P}.tar.bz2"

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
}

src_install() {
	dogamesbin supertux || die "dogamesbin failed"
	dodir ${GAMES_DATADIR}/${PN}
	cp -r data/{images,sounds,music,levels} "${D}${GAMES_DATADIR}/${PN}/" || \
		die "cp failed"
	dodoc {AUTHORS,CHANGES,INSTALL,README,TODO}.txt || die "dodoc failed"
	prepgamesdirs
}

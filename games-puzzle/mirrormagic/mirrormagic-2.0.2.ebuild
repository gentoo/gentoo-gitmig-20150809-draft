# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/mirrormagic/mirrormagic-2.0.2.ebuild,v 1.2 2004/02/20 06:53:36 mr_bones_ Exp $

inherit games flag-o-matic

DESCRIPTION="a game like Deflektor (C 64) or Mindbender (Amiga)"
SRC_URI="http://www.artsoft.org/RELEASES/unix/mirrormagic/${P}.tar.gz"
HOMEPAGE="http://www.artsoft.org/mirrormagic/"

LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"

DEPEND="X? ( virtual/x11 )
	sdl? ( >=media-libs/libsdl-1.1
		>=media-libs/sdl-mixer-1.2.4
		>=media-libs/sdl-image-1.2.2 )
	|| ( X? ( ) sdl? ( ) virtual/x11 )"

src_compile() {
	replace-flags -march=k6 -march=i586

	local makeopts="X11_PATH=/usr/X11R6 RO_GAME_DIR=${GAMES_DATADIR}/${PN} RW_GAME_DIR=${GAMES_STATEDIR}/${PN}"
	if [ `use X` ] || [ -z "`use X``use sdl`" ] ; then
		make clean || die
		make ${makeopts} OPTIONS="${CFLAGS}" x11 || die
		mv mirrormagic{,.x11}
	fi
	if [ `use sdl` ] ; then
		make clean || die
		make ${makeopts} OPTIONS="${CFLAGS}" sdl || die
		mv mirrormagic{,.sdl}
	fi
}

src_install() {
	dogamesbin mirrormagic.{sdl,x11}
	dodir ${GAMES_DATADIR}/${PN}
	cp -R graphics levels music sounds ${D}/${GAMES_DATADIR}/${PN}/
	dodoc CHANGES CREDITS README TODO

	prepgamesdirs
}

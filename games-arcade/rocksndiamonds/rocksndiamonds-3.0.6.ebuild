# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/rocksndiamonds/rocksndiamonds-3.0.6.ebuild,v 1.6 2004/03/28 09:22:26 mr_bones_ Exp $

inherit games flag-o-matic

DESCRIPTION="A Boulderdash clone"
HOMEPAGE="http://www.artsoft.org/rocksndiamonds/"
SRC_URI="http://www.artsoft.org/RELEASES/unix/rocksndiamonds/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc amd64"

DEPEND="virtual/glibc
		X? ( virtual/x11 )
	|| (
		sdl? ( >=media-libs/libsdl-1.2.3
			>=media-libs/sdl-mixer-1.2.4
			>=media-libs/sdl-image-1.2.2 )
		virtual/x11 )"

src_compile() {
	replace-flags -march=k6 -march=i586

	local makeopts="RO_GAME_DIR=${GAMES_DATADIR}/${PN} RW_GAME_DIR=${GAMES_STATEDIR}/${PN}"
	if use X || { ! use X && ! use sdl; } ; then
		make clean || die
		make ${makeopts} OPTIONS="${CFLAGS}" x11 || die
		mv rocksndiamonds{,.x11}
	fi
	if use sdl ; then
		make clean || die
		make ${makeopts} OPTIONS="${CFLAGS}" sdl || die
		mv rocksndiamonds{,.sdl}
	fi
}

src_install() {
	dogamesbin rocksndiamonds.{sdl,x11} || die
	dodir ${GAMES_DATADIR}/${PN}
	cp -R graphics levels music sounds ${D}/${GAMES_DATADIR}/${PN}/

	newman rocksndiamonds.{1,6}
	dodoc CHANGES CREDITS HARDWARE README TODO docs/elements/*.txt

	prepgamesdirs
}

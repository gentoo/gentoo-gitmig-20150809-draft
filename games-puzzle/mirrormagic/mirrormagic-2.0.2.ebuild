# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/mirrormagic/mirrormagic-2.0.2.ebuild,v 1.17 2006/12/06 17:13:18 wolf31o2 Exp $

inherit eutils flag-o-matic games

DESCRIPTION="a game like Deflektor (C 64) or Mindbender (Amiga)"
HOMEPAGE="http://www.artsoft.org/mirrormagic/"
SRC_URI="http://www.artsoft.org/RELEASES/unix/mirrormagic/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64 ppc"
IUSE="sdl"

RDEPEND="!sdl? ( x11-libs/libX11 )
	sdl? (
		>=media-libs/libsdl-1.1
		>=media-libs/sdl-mixer-1.2.4
		>=media-libs/sdl-image-1.2.2 )"
DEPEND="${RDEPEND}
	!sdl? ( x11-libs/libXt )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}"-gcc41.patch
}

src_compile() {
	replace-flags -march=k6 -march=i586

	local makeopts="X11_PATH=/usr/X11R6 RO_GAME_DIR=${GAMES_DATADIR}/${PN} RW_GAME_DIR=${GAMES_STATEDIR}/${PN}"
	make clean || die
	if use sdl ; then
		make ${makeopts} OPTIONS="${CFLAGS}" sdl || die
	else
		make ${makeopts} OPTIONS="${CFLAGS}" x11 || die
	fi
}

src_install() {
	dogamesbin mirrormagic || die "dogamesbin failed"
	dodir "${GAMES_DATADIR}/${PN}"
	cp -R graphics levels music sounds "${D}/${GAMES_DATADIR}/${PN}/"
	dodoc CHANGES CREDITS README TODO
	prepgamesdirs
}

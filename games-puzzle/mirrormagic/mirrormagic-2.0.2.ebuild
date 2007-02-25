# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/mirrormagic/mirrormagic-2.0.2.ebuild,v 1.18 2007/02/25 15:39:21 nyhm Exp $

inherit eutils games

DESCRIPTION="a game like Deflektor (C 64) or Mindbender (Amiga)"
HOMEPAGE="http://www.artsoft.org/mirrormagic/"
SRC_URI="http://www.artsoft.org/RELEASES/unix/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
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
	local makeopts="X11_PATH=/usr/X11R6 RO_GAME_DIR=${GAMES_DATADIR}/${PN} RW_GAME_DIR=${GAMES_STATEDIR}/${PN}"
	emake clean || die
	if use sdl ; then
		emake ${makeopts} OPTIONS="${CFLAGS}" sdl || die
	else
		emake ${makeopts} OPTIONS="${CFLAGS}" x11 || die
	fi
}

src_install() {
	dogamesbin ${PN} || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r graphics levels music sounds || die "doins failed"
	dodoc CHANGES CREDITS README TODO
	prepgamesdirs
}

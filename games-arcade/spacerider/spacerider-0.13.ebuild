# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/spacerider/spacerider-0.13.ebuild,v 1.1 2007/02/18 11:10:36 tupone Exp $

inherit eutils games

DESCRIPTION="space-shooter written in C++, using the SDL"
HOMEPAGE="http://www.hackl.dhs.org/spacerider"
SRC_URI="http://www.hackl.dhs.org/data/download/download.php?file=${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="media-libs/sdl-gfx
		media-libs/sdl-mixer
		media-libs/sdl-image
		media-libs/sdl-net
		media-libs/sdl-ttf"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}"-gentoo.patch \
		"${FILESDIR}/${P}"-gcc41.patch
	sed -i -e "s:/usr/share/games/spacerider:${GAMES_DATADIR}/${PN}:" \
		globals.cpp
}

src_install() {
	dogamesbin ${PN} || die "installing the executable failed"
	insinto ${GAMES_DATADIR}/${PN}
	doins -r data || die "installing game data files"

	dodoc AUTHORS || die "Error installing doc"
	newman ${PN}.{1,6}

	prepgamesdirs
}

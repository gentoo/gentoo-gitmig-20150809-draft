# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/njam/njam-0.96.ebuild,v 1.3 2004/02/20 06:20:00 mr_bones_ Exp $

inherit games eutils

MY_P="${P}-src"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="Multi or single-player network Pacman-like game in SDL"
HOMEPAGE="http://njam.sourceforge.net/"
SRC_URI="mirror://sourceforge/njam/${MY_P}.tar.gz"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=media-libs/sdl-mixer-1.2.5
	>=media-libs/sdl-image-1.2.2
	>=media-libs/libsdl-1.2.5
	>=media-libs/sdl-net-1.2.4"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}/njam.diff
	epatch ${FILESDIR}/${PV}/njamgame.diff
}

src_compile() {
	emake PREFIX="/usr/share" || die "emake failed"
}

src_install() {
	dogamesbin njam

	dodoc CHANGES README TODO

	dohtml html/*

	insinto ${GAMES_DATADIR}/njam/data
	doins data/*

	insinto ${GAMES_DATADIR}/njam/skins
	doins skins/*

	prepgamesdirs
}

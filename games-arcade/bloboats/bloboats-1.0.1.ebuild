# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/bloboats/bloboats-1.0.1.ebuild,v 1.1 2010/08/25 17:36:52 mr_bones_ Exp $

EAPI=2
inherit games

DESCRIPTION="arcade-like boat racing game combining platform jumpers and elastomania / x-moto like games"
HOMEPAGE="http://bloboats.dy.fi/"
SRC_URI="http://mirror.kapsi.fi/bloboats.dy.fi/${P}.tar.gz"

LICENSE="GPL-2 CCPL-Sampling-Plus-1.0"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="media-libs/libsdl[video]
	media-libs/sdl-mixer[vorbis]
	media-libs/sdl-image[png]
	media-libs/sdl-net
	media-libs/libvorbis"

src_prepare() {
	sed -i \
		-e "/PREFIX/s://:${D}:" \
		-e "/DATADIR/s:/usr/games/bloboats/data:${GAMES_DATADIR}/${PN}:" \
		-e "/BINARYDIR/s:/usr/bin:${GAMES_BINDIR}:" \
		-e "/CONFIGDIR/s:/etc:${GAMES_SYSCONFDIR}:" \
		-e "/CXXFLAGS_DEFAULT/s:-O2:${CXXFLAGS} \$(LDFLAGS):" \
		-e "/^CXX[ _]/d" \
		-e '/STRIP/d' \
		Makefile \
		|| die 'sed Makefile failed'
}

src_install() {
	dogamesbin bin/bloboats || die
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r data/* || die
	insinto "$GAMES_SYSCONFDIR"
	doins bloboats.dirs || die
	dodoc readme.txt
	prepgamesdirs
}

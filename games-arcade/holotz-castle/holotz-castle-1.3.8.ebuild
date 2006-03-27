# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/holotz-castle/holotz-castle-1.3.8.ebuild,v 1.1 2006/03/27 07:22:45 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="2d platform jump'n'run game"
HOMEPAGE="http://www.mainreactor.net/holotzcastle/en/index_en.html"
SRC_URI="http://www.mainreactor.net/holotzcastle/download/${P}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/opengl
	media-libs/sdl-mixer
	media-libs/libsdl
	media-libs/sdl-ttf
	media-libs/sdl-image"

S=${WORKDIR}/${P}-src

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-build.patch
}

src_compile() {
	emake -C JLib CPU_OPTS="${CXXFLAGS}" || die "emake failed"
	emake -C src CPU_OPTS="${CXXFLAGS}" || die "emake failed"
}

src_install() {
	dogamesbin holotz-castle holotz-castle-editor || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}"/${PN}/game
	doins -r HCedHome/* res/* || die "doins failed"
	dodoc MANUAL*.txt
	doman doc/*.6
	prepgamesdirs
}

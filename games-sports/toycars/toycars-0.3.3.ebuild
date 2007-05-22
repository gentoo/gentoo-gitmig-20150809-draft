# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-sports/toycars/toycars-0.3.3.ebuild,v 1.1 2007/05/22 16:08:03 nyhm Exp $

inherit autotools eutils games

DESCRIPTION="a physics based 2-D racer inspired by Micro Machines"
HOMEPAGE="http://sourceforge.net/projects/toycars"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-mixer
	media-libs/openal
	media-libs/freealut
	virtual/glu
	virtual/opengl"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-asneeded.patch
	AT_M4DIR=m4 eautoreconf
}

src_install() {
	dogamesbin src/${PN} || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r data || die "doins failed"
	newicon celica-render.png ${PN}.png
	make_desktop_entry ${PN} "Toy Cars"
	dodoc AUTHORS ChangeLog README TODO
	prepgamesdirs
}

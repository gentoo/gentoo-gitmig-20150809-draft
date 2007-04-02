# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-sports/toycars/toycars-0.3.2.ebuild,v 1.5 2007/04/02 19:48:47 tupone Exp $

WANT_AUTOMAKE="1.6"

inherit autotools eutils games

DESCRIPTION="a physics based 2-D racer inspired by Micromachines"
HOMEPAGE="http://sourceforge.net/projects/toycars"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-mixer
	virtual/glu
	virtual/opengl"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-asneeded.patch
	eautomake
}

src_install() {
	dogamesbin src/${PN} || die "Failed installing ${PN} executable"
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r data || die "installing data failed"

	dodoc AUTHORS ChangeLog README TODO

	prepgamesdirs
}

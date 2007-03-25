# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-sports/toycars/toycars-0.3.2.ebuild,v 1.1 2007/03/25 13:37:22 tupone Exp $

inherit games

DESCRIPTION="a physics based 2-D racer inspired by Micromachines"
HOMEPAGE="http://sourceforge.net/projects/toycars"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-mixer
	virtual/glu
	virtual/opengl"

src_install() {
	dogamesbin src/${PN} || die "Failed installing ${PN} executable"
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r data || die "installing data failed"

	dodoc AUTHORS ChangeLog README TODO

	prepgamesdirs
}

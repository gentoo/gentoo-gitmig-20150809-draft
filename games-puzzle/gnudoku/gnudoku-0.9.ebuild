# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/gnudoku/gnudoku-0.9.ebuild,v 1.1 2005/06/28 03:47:15 mr_bones_ Exp $

inherit eutils games

MY_PN="GNUDoku"
MY_P=${MY_PN}-${PV}
DESCRIPTION="A program for creating and solving Su Doku puzzles"
HOMEPAGE="http://www.icculus.org/~jcspray/GNUDoku"
SRC_URI="http://www.icculus.org/~jcspray/GNUDoku/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-cpp/gtkmm-2.6"

S=${WORKDIR}/${MY_P}

src_install() {
	dogamesbin GNUDoku || die "dogamesbin failed"
	newicon GNUDoku.png ${PN}.png
	make_desktop_entry ${MY_PN} ${MY_PN}
	prepgamesdirs
}

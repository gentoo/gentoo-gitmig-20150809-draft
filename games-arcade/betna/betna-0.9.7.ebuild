# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/betna/betna-0.9.7.ebuild,v 1.8 2007/03/13 20:38:04 nyhm Exp $

inherit eutils games

DESCRIPTION="Defend your volcano from the attacking ants by firing rocks/bullets at them"
HOMEPAGE="http://koti.mbnet.fi/makegho/c/betna/"
SRC_URI="http://koti.mbnet.fi/makegho/c/betna/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86"
IUSE=""

DEPEND="media-libs/libsdl"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i \
		-e "s:images/:${GAMES_DATADIR}/${PN}/:" \
		src/main.cpp || die "sed main.cpp failed"

	sed -i \
		-e "s:-O2:${CXXFLAGS}:" \
		Makefile || die "sed Makefile failed"

	emake clean
}

src_install() {
	dogamesbin betna || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins images/* || die "doins failed"
	newicon images/target.bmp ${PN}.bmp
	make_desktop_entry ${PN} Betna /usr/share/pixmaps/${PN}.bmp
	dodoc README Q\&A
	prepgamesdirs
}

# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/fruit/fruit-2.1.ebuild,v 1.2 2007/02/13 17:29:10 peper Exp $

inherit eutils versionator games

MY_PV=$(replace_all_version_separators '')
MY_P=${PN}_${MY_PV}_linux

DESCRIPTION="UCI-only chess engine."
HOMEPAGE="http://arctrix.com/nas/fruit/"
SRC_URI="http://arctrix.com/nas/${PN}/${MY_P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-arch/unzip"

S=${WORKDIR}/${MY_P}/src

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}"-gentoo.patch
	sed -i -e "s:@GENTOO_DATADIR@:${GAMES_DATADIR}/${PN}:" \
		option.cpp
	sed -i -e "/^CXXFLAGS/d" Makefile
}

src_install() {
	dogamesbin ${PN} || die "Cannot install ${PN}"

	insinto "${GAMES_DATADIR}/${PN}"
	doins ../book_small.bin || die "Cannot install book"
	dodoc ../readme.txt ../technical_10.txt || die "Cannot install doc"

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst

	einfo "To use this engine you need to install a chess GUI that talk UCI"
	einfo "emerge games-board/glchess to have one"
}

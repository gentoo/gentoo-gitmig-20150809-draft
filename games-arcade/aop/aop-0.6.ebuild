# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/aop/aop-0.6.ebuild,v 1.1 2004/12/02 10:26:27 mr_bones_ Exp $

inherit games

DESCRIPTION="Ambassador of Pain is a cursed based game with only 64 lines of code."
HOMEPAGE="http://aop.raffi.at/"
SRC_URI="http://www.raffi.at/code/${PN}/${P}.tar.gz"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="sys-libs/ncurses"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "s#/usr/local/share#${GAMES_DATADIR}#" \
		aop.c \
		|| die "sed failed"
}

src_install() {
	dogamesbin aop || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}/${PN}"
	doins aop-level-*.txt || die "doins failed"
	prepgamesdirs
}


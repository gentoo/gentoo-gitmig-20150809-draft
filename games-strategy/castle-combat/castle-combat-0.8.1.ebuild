# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/castle-combat/castle-combat-0.8.1.ebuild,v 1.1 2006/07/29 23:05:56 tupone Exp $

inherit games

DESCRIPTION="A clone of the old arcade game Rampart"
HOMEPAGE="http://www.linux-games.com/castle-combat/"
SRC_URI="mirror://sourceforge/castle-combat/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="dev-python/twisted
	dev-python/pygame"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e "s:src:${GAMES_LIBDIR}/${PN}:"	\
		castle-combat.py
	sed -i -e "/data_path =/s:\"data:\"${GAMES_DATADIR}/${PN}:"	\
		src/common.py
}

src_install() {
	newgamesbin castle-combat.py castle-combat
	insinto ${GAMES_LIBDIR}/${PN}
	doins src/*
	insinto ${GAMES_DATADIR}/${PN}
	doins -r data/{colourba.ttf,gfx,sound}
	dohtml -r data/font_read_me.html data/doc
	dodoc TODO
	prepgamesdirs
}

# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/openrpg/openrpg-1.4.1.ebuild,v 1.1 2003/09/10 06:26:50 vapier Exp $

inherit games

DESCRIPTION="Open RPG Client"
SRC_URI="mirror://sourceforge/openrpg/${P}.tar.gz"
HOMEPAGE="http://www.openrpg.com/"

KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"

DEPEND=">=dev-python/wxPython-2.3.3.1
	>=dev-lang/python-2.2.1"

S=${WORKDIR}/${PN}1

src_install() {
	dodir ${GAMES_DATADIR}/${PN}
	dodoc readme.txt
	rm readme.txt license.txt
	cp -r * ${D}/${GAMES_DATADIR}/${PN}

	dogamesbin ${FILESDIR}/openrpg
	dosed "s:GENTOO_DIR:${GAMES_DATADIR}/${PN}:" ${GAMES_BINDIR}/openrpg
	dogamesbin ${FILESDIR}/openrpg-server
	dosed "s:GENTOO_DIR:${GAMES_DATADIR}/${PN}:" ${GAMES_BINDIR}/openrpg-server

	prepgamesdirs
}

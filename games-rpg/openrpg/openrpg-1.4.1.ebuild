# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/openrpg/openrpg-1.4.1.ebuild,v 1.3 2004/03/12 10:13:43 mr_bones_ Exp $

inherit games

DESCRIPTION="Open RPG Client"
HOMEPAGE="http://www.openrpg.com/"
SRC_URI="mirror://sourceforge/openrpg/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

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

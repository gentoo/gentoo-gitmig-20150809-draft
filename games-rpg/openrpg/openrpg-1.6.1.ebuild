# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/openrpg/openrpg-1.6.1.ebuild,v 1.1 2004/01/18 04:21:38 vapier Exp $

inherit games eutils

DESCRIPTION="Open RPG Client"
HOMEPAGE="http://www.openrpg.com/"
SRC_URI="mirror://sourceforge/openrpg/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=dev-python/wxPython-2.4.0.2
	>=dev-lang/python-2.2.2"

S=${WORKDIR}/${PN}1

src_unpack() {
	unpack ${A}
	cd ${S}
	edos2unix *.py
	epatch ${FILESDIR}/${PV}-gentoo-paths.patch
	find -name CVS -type d -exec rm -rf '{}' \; 2>/dev/null
}

src_install() {
	dodoc readme.txt
	rm readme.txt license.txt

	newgamesbin start.py openrpg
	dosed "s:GENTOO_DATADIR:${GAMES_DATADIR}/${PN}:" ${GAMES_BINDIR}/openrpg
	dosed "s:GENTOO_LIBDIR:${GAMES_LIBDIR}/${PN}:" ${GAMES_BINDIR}/openrpg
	newgamesbin start_server.py openrpg-server
	dosed "s:GENTOO_DATADIR:${GAMES_DATADIR}/${PN}:" ${GAMES_BINDIR}/openrpg-server
	dosed "s:GENTOO_LIBDIR:${GAMES_LIBDIR}/${PN}:" ${GAMES_BINDIR}/openrpg-server
	newgamesbin start_server_gui.py openrpg-server-gui
	dosed "s:GENTOO_DATADIR:${GAMES_DATADIR}/${PN}:" ${GAMES_BINDIR}/openrpg-server-gui
	dosed "s:GENTOO_LIBDIR:${GAMES_LIBDIR}/${PN}:" ${GAMES_BINDIR}/openrpg-server-gui
	rm start.py start_server.py start_server_gui.py

	insinto ${GAMES_LIBDIR}/${PN}
	doins *.py
	mv orpg/templates .
	cp -r orpg ${D}/${GAMES_LIBDIR}/${PN}/
	rm -rf orpg *.py

	dodir ${GAMES_DATADIR}/${PN}
	dodir ${GAMES_DATADIR}/${PN}/orpg
	mv templates ${D}/${GAMES_DATADIR}/${PN}/orpg/
	cp -r * ${D}/${GAMES_DATADIR}/${PN}

	dodir ${GAMES_DATADIR}/${PN}/myfiles
	prepgamesdirs
	# i dont like this but the game needs to be rewritten more than
	# i care to do myself to support ${HOME}/.openrpg
	fperms g+w ${GAMES_DATADIR}/${PN}/myfiles
}

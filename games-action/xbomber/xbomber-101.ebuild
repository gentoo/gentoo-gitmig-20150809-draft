# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/xbomber/xbomber-101.ebuild,v 1.2 2004/02/20 06:13:57 mr_bones_ Exp $

inherit games

DESCRIPTION="Bomberman clone w/multiplayer support"
SRC_URI="http://www.xdr.com/dash/${P}.tgz"
HOMEPAGE="http://www.xdr.com/dash/bomber.html"

LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"

DEPEND="virtual/x11
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i "s:X386:X11R6:" Makefile
	sed -i "s:data/%s:${GAMES_DATADIR}/${PN}/%s:" bomber.c
	sed -i "s:=\"data\":=\"${GAMES_DATADIR}/${PN}\":" sound.c
}

src_compile() {
	emake CFLAGS="${CFLAGS}" || die
}

src_install() {
	dogamesbin matcher bomber
	dodir ${GAMES_DATADIR}/${PN}
	cp -r data/* ${D}/${GAMES_DATADIR}/${PN}/
	dodoc README Changelog
	prepgamesdirs
}

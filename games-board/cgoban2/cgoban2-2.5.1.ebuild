# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/cgoban2/cgoban2-2.5.1.ebuild,v 1.2 2003/09/27 01:19:14 vapier Exp $

inherit games

DESCRIPTION="A Java client for the Kiseido Go Server, and a SGF editor"
HOMEPAGE="http://kgs.kiseido.com/"
SRC_URI="http://kgs.kiseido.com/cgoban-unix-${PV}.tar.bz2"

LICENSE="freedist"
SLOT="0"
KEYWORDS="x86"

RDEPEND=">=virtual/jre-1.3
	virtual/x11"

S=${WORKDIR}/cgoban

src_install() {
	dogamesbin ${FILESDIR}/cgoban2
	dosed "s:GENTOO_DIR:${GAMES_DATADIR}/${PN}:" ${GAMES_BINDIR}/cgoban2
	insinto ${GAMES_DATADIR}/${PN}
	doins cgoban.jar
	prepgamesdirs
}

# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/cgoban2/cgoban2-2.5.1.ebuild,v 1.1 2003/09/10 17:46:27 vapier Exp $

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

src_unpack() {
	unpack ${A}
	cd ${S}
	sed \
		-e 's;_DIR=.;_DIR='"${GAMES_DATADIR}/${PN}"';' \
		< cgoban.sh.in > cgoban2 || die "sed cgoban.sh.in failed"
}

src_install() {
	dogamesbin cgoban2
	insinto "${GAMES_DATADIR}/${PN}"
	doins cgoban.jar
	prepgamesdirs
}

# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/penguzzle/penguzzle-1.0.ebuild,v 1.2 2004/02/20 06:53:36 mr_bones_ Exp $

inherit games

DESCRIPTION="Tcl/Tk variant of the well-known 15-puzzle game"
HOMEPAGE="http://www.naskita.com/linux/penguzzle/penguzzle.shtml"
SRC_URI="http://www.naskita.com/linux/penguzzle/${PN}.zip"

LICENSE="penguzzle"
SLOT="0"
KEYWORDS="x86"

DEPEND="dev-tcltk/tclx"

S=${WORKDIR}/${PN}${PV}

src_install() {
	insinto ${GAMES_DATADIR}/${PN}
	doins images/*

	insinto ${GAMES_LIBDIR}/${PN}
	doins lib/*
	dosed "s:~/puzz/images:${GAMES_DATADIR}/${PN}:" ${GAMES_LIBDIR}/${PN}/init

	dogamesbin bin/*
	dosed "s:~/puzz/lib:${GAMES_LIBDIR}/${PN}:" ${GAMES_BINDIR}/penguzzle

	dodoc README
	prepgamesdirs
}

# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-kids/tuxmathscrabble/tuxmathscrabble-2.2.ebuild,v 1.1 2003/09/10 04:51:18 vapier Exp $

inherit eutils games

DESCRIPTION="math-version of the popular board game for children 4-10"
HOMEPAGE="http://sourceforge.net/projects/tuxmathscrabble/"
SRC_URI="mirror://sourceforge/tuxmathscrabble/TuxMathScrabble.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND=""
RDEPEND="dev-python/pygame
	dev-lang/python"

S=${WORKDIR}/TuxMathScrabble

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-gentoo-paths.patch
	sed -i "s:GENTOO_DATADIR:${GAMES_DATADIR}/${PN}/:" tuxmathscrabble.py
}

src_install() {
	dogamesbin ${FILESDIR}/tuxmathscrabble
	dosed "s:GENTOO_LIBDIR:${GAMES_LIBDIR}/${PN}:" ${GAMES_BINDIR}/tuxmathscrabble
	exeinto ${GAMES_LIBDIR}/${PN}
	doexe tuxmathscrabble.py
	cp -r asymptopia ${D}/${GAMES_LIBDIR}/${PN}/

	insinto ${GAMES_DATADIR}/${PN}/font
	doins font/*
	insinto ${GAMES_DATADIR}/${PN}/images
	doins images/*

	dodoc AUTHOR README
	prepgamesdirs
}

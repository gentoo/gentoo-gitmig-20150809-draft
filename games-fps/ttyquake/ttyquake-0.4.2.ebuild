# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/ttyquake/ttyquake-0.4.2.ebuild,v 1.1 2003/09/09 18:10:14 vapier Exp $

inherit games eutils gcc

DESCRIPTION="Play Quake at a text terminal, in an xterm, or over a telnet session"
HOMEPAGE="http://webpages.mr.net/bobz/ttyquake/"
SRC_URI="ftp://ftp.skypoint.com/pub/members/b/bobz/${P}.tar.gz
	http://webpages.mr.net/bobz/ttyquake/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

RDEPEND="app-games/quake1"

S=${WORKDIR}

pkg_setup() {
	[ -x ${GAMES_BINDIR}/squake ] || die "You must emerge quake1 with svga in your USE"
	games_pkg_setup
}

src_install() {
	exeinto ${GAMES_LIBDIR}/${PN}
	doexe tty/*
	dogamesbin ${FILESDIR}/ttyquake
	dosed "s:GENTOO_LIBDIR:${GAMES_LIBDIR}/${PN}:" ${GAMES_BINDIR}/ttyquake
	dosed "s:GENTOO_BINDIR:${GAMES_BINDIR}:" ${GAMES_BINDIR}/ttyquake

	dodoc README.ttyquake
	prepgamesdirs
}

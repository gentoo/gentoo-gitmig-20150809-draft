# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/ttyquake/ttyquake-0.4.2.ebuild,v 1.8 2006/04/13 21:14:52 wolf31o2 Exp $

inherit eutils games

DESCRIPTION="Play Quake at a text terminal, in an xterm, or over a telnet session"
HOMEPAGE="http://webpages.mr.net/bobz/ttyquake/"
SRC_URI="ftp://ftp.skypoint.com/pub/members/b/bobz/${P}.tar.gz
	http://webpages.mr.net/bobz/ttyquake/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-*"
IUSE=""

RDEPEND="games-fps/quake1"

S="${WORKDIR}"

pkg_setup() {
	games_pkg_setup
	[ -x "${GAMES_BINDIR}/squake" ] \
		|| die "You must emerge quake1 with svga in your USE"
}

src_install() {
	exeinto "${GAMES_LIBDIR}/${PN}"
	doexe tty/*
	dogamesbin ${FILESDIR}/ttyquake
	dosed "s:GENTOO_LIBDIR:${GAMES_LIBDIR}/${PN}:" ${GAMES_BINDIR}/ttyquake
	dosed "s:GENTOO_BINDIR:${GAMES_BINDIR}:" ${GAMES_BINDIR}/ttyquake

	dodoc README.ttyquake
	prepgamesdirs
}

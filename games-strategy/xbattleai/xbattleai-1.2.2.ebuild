# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/xbattleai/xbattleai-1.2.2.ebuild,v 1.1 2006/03/22 04:09:19 wolf31o2 Exp $

inherit games

DESCRIPTION="A multi-player game of strategy and coordination"
HOMEPAGE="http://www.lysator.liu.se/~mbrx/XBattleAI/index.html"
SRC_URI="http://www.lysator.liu.se/~mbrx/XBattleAI/${P}.tgz"

LICENSE="xbattle"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# Since this uses similar code and the same binary name as the original XBattle,
# we want to make sure you can't install both at the same time

RDEPEND="|| (
	(
		x11-libs/libXext
		x11-libs/libX11 )
	virtual/x11 )"
DEPEND="${RDEPEND}
	|| (
		(
			x11-proto/xproto
			x11-libs/libX11
			app-text/rman
			x11-misc/imake )
		virtual/x11 )
	!games-strategy/xbattle"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e "/TARGET/s:/usr/bin/:${GAMES_BINDIR}:" Makefile || die "sed Makefile failed"
}

src_install() {
	dogamesbin "xbattle" || die "installing the binary failed"
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r xbas xbos xbts || die "installing data failed"
	newman xbattle.man xbattle.6
	dodoc README xbattle.dot
	prepgamesdirs
}

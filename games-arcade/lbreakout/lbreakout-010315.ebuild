# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/lbreakout/lbreakout-010315.ebuild,v 1.4 2004/02/29 09:21:24 vapier Exp $

inherit games

DESCRIPTION="Breakout clone written with the SDL library"
HOMEPAGE="http://lgames.sourceforge.net"
SRC_URI="mirror://sourceforge/lgames/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc amd64"

DEPEND=">=media-libs/libsdl-1.1.5"

src_compile() {
	egamesconf --datadir="${GAMES_DATADIR_BASE}" || die
	emake || die "emake failed"
}

src_install() {
	# makefile fails to create this directory
	dodir /var/lib/games
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS README ChangeLog
	dohtml lbreakout/manual/*
	prepgamesdirs
}

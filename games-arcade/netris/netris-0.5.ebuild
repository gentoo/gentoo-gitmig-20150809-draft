# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/netris/netris-0.5.ebuild,v 1.1 2003/09/10 19:29:21 vapier Exp $

inherit games

DESCRIPTION="Classic networked version of T*tris"
HOMEPAGE="http://www.netris.org/"
SRC_URI="ftp://ftp.netris.org/pub/netris/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="sys-libs/ncurses"

src_compile() {
	./Configure --copt "${CFLAGS}" || die "Configure failed"
	emake || die "emake failed"
}

src_install() {
	dogamesbin netris sr
	dodoc FAQ README robot_desc
	prepgamesdirs
}

# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/xskat/xskat-3.4-r1.ebuild,v 1.1 2003/09/13 10:44:27 msterret Exp $

inherit games

DESCRIPTION="Famous german card game"
HOMEPAGE="http://www.gulu.net/xskat"
SRC_URI="http://www.gulu.net/xskat/${P}.tar.gz"

KEYWORDS="x86 ppc"
LICENSE="freedist"
SLOT="0"

DEPEND="virtual/x11"

src_compile() {
	xmkmf -a || die "xmkmf failed"
	emake CDEBUGFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	dogamesbin xskat
	newman xskat.man xskat.6
	dodoc CHANGES README{,.IRC}
	prepgamesdirs
}

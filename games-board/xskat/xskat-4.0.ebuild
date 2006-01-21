# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/xskat/xskat-4.0.ebuild,v 1.3 2006/01/21 18:04:50 wolf31o2 Exp $

inherit games

DESCRIPTION="Famous german card game"
HOMEPAGE="http://www.xskat.de/xskat.html"
SRC_URI="http://www.xskat.de/${P}.tar.gz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="|| (
	x11-libs/libX11
	virtual/x11 )"
RDEPEND="${DEPEND}
	|| (
		x11-proto/xproto
		virtual/x11 )"

src_compile() {
	xmkmf -a || die "xmkmf failed"
	emake CDEBUGFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	dogamesbin xskat || die "dogamesbin failed"
	newman xskat.man xskat.6
	dodoc CHANGES README{,.IRC}
	prepgamesdirs
}

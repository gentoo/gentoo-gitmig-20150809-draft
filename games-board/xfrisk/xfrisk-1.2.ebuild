# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/xfrisk/xfrisk-1.2.ebuild,v 1.4 2004/06/24 22:22:20 agriffis Exp $

inherit games

S="${WORKDIR}/XFrisk"
DESCRIPTION="The RISK board game"
SRC_URI="http://morphy.iki.fi/xfrisk/files/${P}.tar.gz"
HOMEPAGE="http://morphy.iki.fi/xfrisk/"

KEYWORDS="x86 ppc sparc amd64"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

RDEPEND="virtual/x11
	x11-libs/Xaw3d"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e "s:/usr/local:${GAMES_PREFIX}:" Makefile \
			|| die "sed Makefile failed"
}

src_install() {
	make PREFIX="${D}/${GAMES_PREFIX}" install || die "make install failed"
	dodoc BUGS ChangeLog FAQ TODO || die "dodoc failed"
	prepgamesdirs
}

# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/xfrisk/xfrisk-1.2.ebuild,v 1.1 2003/09/10 17:46:27 vapier Exp $

inherit games

S=${WORKDIR}/XFrisk
DESCRIPTION="The RISK board game"
SRC_URI="http://morphy.iki.fi/xfrisk/files/${P}.tar.gz"
HOMEPAGE="http://morphy.iki.fi/xfrisk/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc"

DEPEND="x11-libs/Xaw3d
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e "s:/usr/local:${GAMES_PREFIX}:" \
		Makefile || \
			die "sed Makefile failed"
}

src_compile() {
	emake || die
}

src_install() {
	make PREFIX=${D}/${GAMES_PREFIX} install || die "make install failed"
	dodoc BUGS ChangeLog FAQ TODO
	prepgamesdirs
}

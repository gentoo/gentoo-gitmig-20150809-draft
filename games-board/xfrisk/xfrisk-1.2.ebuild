# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/xfrisk/xfrisk-1.2.ebuild,v 1.6 2006/04/23 06:48:57 mr_bones_ Exp $

inherit games

DESCRIPTION="The RISK board game"
HOMEPAGE="http://morphy.iki.fi/xfrisk/"
SRC_URI="http://morphy.iki.fi/xfrisk/files/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="amd64 ppc sparc x86"
SLOT="0"
IUSE=""

RDEPEND="|| ( x11-libs/libXmu virtual/x11 )
	x11-libs/Xaw3d"
DEPEND="${RDEPEND}
	|| ( x11-libs/libXaw virtual/x11 )
	>=sys-apps/sed-4"

S=${WORKDIR}/XFrisk

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "s:/usr/local:${GAMES_PREFIX}:" Makefile \
		|| die "sed failed"
}

src_install() {
	make PREFIX="${D}/${GAMES_PREFIX}" install || die "make install failed"
	dodoc BUGS ChangeLog FAQ TODO
	prepgamesdirs
}

# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/xfrisk/xfrisk-1.2.ebuild,v 1.7 2006/08/22 08:05:37 mr_bones_ Exp $

inherit games

DESCRIPTION="The RISK board game"
HOMEPAGE="http://tuxick.net/xfrisk/"
SRC_URI="http://tuxick.net/xfrisk/files/XFrisk-${PV}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="amd64 ppc sparc x86"
SLOT="0"
IUSE=""

RDEPEND="|| ( x11-libs/libXmu virtual/x11 )
	x11-libs/Xaw3d"
DEPEND="${RDEPEND}
	|| ( x11-libs/libXaw virtual/x11 )"

S=${WORKDIR}/XFrisk

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "s:/usr/local:${GAMES_PREFIX}:" \
		Makefile \
		|| die "sed failed"
}

src_install() {
	emake PREFIX="${D}/${GAMES_PREFIX}" install || die "emake install failed"
	dodoc BUGS ChangeLog FAQ TODO
	prepgamesdirs
}

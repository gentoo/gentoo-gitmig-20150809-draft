# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-server/monopd/monopd-0.9.3-r1.ebuild,v 1.1 2006/03/03 19:57:25 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="server for atlantik games"
HOMEPAGE="http://unixcode.org/monopd/"
SRC_URI="http://unixcode.org/downloads/monopd/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE=""

DEPEND=">=net-libs/libcapsinetwork-0.3.0
	>=sys-libs/libmath++-0.0.3"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-dosfix.patch"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc doc/api/gameboard API AUTHORS ChangeLog NEWS README* TODO
	doinitd "${FILESDIR}"/monopd || die "doinitd failed"
	prepgamesdirs
}

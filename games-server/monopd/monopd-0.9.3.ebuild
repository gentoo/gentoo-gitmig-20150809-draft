# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-server/monopd/monopd-0.9.3.ebuild,v 1.2 2004/11/08 11:30:15 mr_bones_ Exp $

inherit games

DESCRIPTION="server for atlantik games"
HOMEPAGE="http://unixcode.org/monopd/"
SRC_URI="http://unixcode.org/downloads/monopd/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

DEPEND=">=net-libs/libcapsinetwork-0.3.0
	>=sys-libs/libmath++-0.0.3"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc doc/api/gameboard API AUTHORS ChangeLog NEWS README* TODO

	exeinto /etc/init.d
	doexe "${FILESDIR}/monopd" || die "doexe failed"

	prepgamesdirs
}

# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-server/monopd/monopd-0.9.0.ebuild,v 1.1 2004/04/18 20:19:37 vapier Exp $

inherit games

DESCRIPTION="server for atlantik games"
HOMEPAGE="http://unixcode.org/monopd/"
SRC_URI="http://unixcode.org/downloads/monopd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=">=net-libs/libcapsinetwork-0.2.3
	>=sys-libs/libmath++-0.0.3"

src_install() {
	make install DESTDIR=${D} || die "make install failed"
	dodoc doc/api/gameboard API AUTHORS ChangeLog NEWS README* TODO

	exeinto /etc/init.d
	doexe ${FILESDIR}/monopd || die "doexe failed"

	prepgamesdirs
}

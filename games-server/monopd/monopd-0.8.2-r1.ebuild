# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-server/monopd/monopd-0.8.2-r1.ebuild,v 1.2 2004/02/20 07:31:48 mr_bones_ Exp $

inherit games

DESCRIPTION="server for atlantik games"
HOMEPAGE="http://unixcode.org/monopd/"
SRC_URI="mirror://sourceforge/monopd/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"

DEPEND=">=net-libs/libcapsinetwork-0.2.3
	>=sys-libs/libmath++-0.0.3"

src_install() {
	make install DESTDIR=${D} || die "make install failed"
	dodoc doc/api/gameboard API AUTHORS ChangeLog INSTALL NEWS README* TODO

	exeinto /etc/init.d
	doexe ${FILESDIR}/monopd

	prepgamesdirs
}

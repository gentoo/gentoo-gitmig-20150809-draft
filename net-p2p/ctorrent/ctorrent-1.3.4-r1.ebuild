# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/ctorrent/ctorrent-1.3.4-r1.ebuild,v 1.1 2004/11/29 03:22:27 squinky86 Exp $

DESCRIPTION="CTorrent is a BitTorrent console client written in C."
HOMEPAGE="http://ctorrent.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND=">=sys-apps/sed-4"

RDEPEND="virtual/libc
	dev-libs/openssl"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e "s:CXXFLAGS=\":CXXFLAGS=\"${CXXFLAGS} :g" configure
	sed -i -e "s:CFLAGS=\":CFLAGS=\"${CFLAGS} :g" configure
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README NEWS
}

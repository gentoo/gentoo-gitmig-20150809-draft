# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/ctorrent/ctorrent-1.3.4.ebuild,v 1.2 2004/10/14 20:11:46 dholm Exp $

DESCRIPTION="CTorrent is a BitTorrent console client written in C."
HOMEPAGE="http://ctorrent.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND="virtual/libc
	dev-libs/openssl"

src_install() {
	make DESTDIR=${D} install || die
	dodoc README NEWS
}

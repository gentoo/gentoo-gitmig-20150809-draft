# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/tcpick/tcpick-0.2.1.ebuild,v 1.4 2006/02/16 00:02:25 jokey Exp $

DESCRIPTION="TCP Stream Sniffer and Connection Tracker"
HOMEPAGE="http://tcpick.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"

IUSE=""
DEPEND="virtual/libc
	net-libs/libpcap"

src_install() {
	make install DESTDIR="${D}" || die "install failed"

	dodoc AUTHORS ChangeLog INTERNALS KNOWN-BUGS OPTIONS README THANKS TODO
	dohtml doc/*.html
}

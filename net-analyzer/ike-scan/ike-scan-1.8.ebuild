# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ike-scan/ike-scan-1.8.ebuild,v 1.1 2005/12/07 17:24:26 vanquirius Exp $

DESCRIPTION="A utility for finding, fingerprinting and testing IKE VPN servers"
HOMEPAGE="http://www.nta-monitor.com/ike-scan/"
SRC_URI="http://www.nta-monitor.com/ike-scan/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="ssl"

DEPEND="virtual/libc
	ssl? ( dev-libs/openssl )"

src_compile() {
	econf $(use_with ssl openssl) || die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc ChangeLog NEWS README TODO
	dodoc udp-backoff-fingerprinting-paper.txt
}

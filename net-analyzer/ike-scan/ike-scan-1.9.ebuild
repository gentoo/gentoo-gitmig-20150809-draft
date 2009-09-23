# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ike-scan/ike-scan-1.9.ebuild,v 1.4 2009/09/23 18:20:03 patrick Exp $

DESCRIPTION="A utility for finding, fingerprinting and testing IKE VPN servers"
HOMEPAGE="http://www.nta-monitor.com/ike-scan/"
SRC_URI="http://www.nta-monitor.com/ike-scan/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE="ssl"

DEPEND="ssl? ( dev-libs/openssl )"

src_compile() {
	# --disable-lookup prevents ike-scan from phoning home
	# for more information, please see bug 157507
	econf $(use_with ssl openssl) --disable-lookup || die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc ChangeLog NEWS README TODO
	dodoc udp-backoff-fingerprinting-paper.txt
}

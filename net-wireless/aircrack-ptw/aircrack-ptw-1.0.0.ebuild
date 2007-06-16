# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/aircrack-ptw/aircrack-ptw-1.0.0.ebuild,v 1.2 2007/06/16 18:43:15 dertobi123 Exp $

DESCRIPTION="Improved WLAN tool for breaking 802.11 WEP keys"
HOMEPAGE="http://www.cdc.informatik.tu-darmstadt.de/aircrack-ptw/"
SRC_URI="http://www.cdc.informatik.tu-darmstadt.de/${PN}/download/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="net-libs/libpcap"
RDEPEND="${DEPEND}
	net-wireless/aircrack-ng"

src_compile() {
	emake aircrack-ptw attacksim
}

src_install() {
	dobin aircrack-ptw attacksim
	dodoc README
}

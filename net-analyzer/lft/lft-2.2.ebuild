# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/lft/lft-2.2.ebuild,v 1.2 2004/06/24 22:06:28 agriffis Exp $

DESCRIPTION="Layer Four Traceroute: an advanced traceroute implementation"
HOMEPAGE="http://www.mainnerve.com/lft/"
SRC_URI="http://mainnerve.com/lft/${P}.tar.gz"

LICENSE="MainNerve"
SLOT="0"
KEYWORDS="~x86"

DEPEND="net-libs/libpcap"

src_install() {
	einstall || die
	dodoc CHANGELOG README TODO
}

# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/lft/lft-2.2.ebuild,v 1.4 2005/01/29 05:12:51 dragonheart Exp $

DESCRIPTION="Layer Four Traceroute: an advanced traceroute implementation"
HOMEPAGE="http://www.mainnerve.com/lft/"
SRC_URI="http://mainnerve.com/lft/${P}.tar.gz"

LICENSE="MainNerve"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/libpcap"

src_install() {
	einstall || die
	dodoc CHANGELOG README TODO
}

# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/lft/lft-2.2.ebuild,v 1.5 2005/01/30 14:24:51 luckyduck Exp $

DESCRIPTION="Layer Four Traceroute: an advanced traceroute implementation"
HOMEPAGE="http://www.mainnerve.com/lft/"
SRC_URI="http://mainnerve.com/lft/${P}.tar.gz"

LICENSE="MainNerve"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE=""

DEPEND="virtual/libpcap"

src_install() {
	einstall || die "make install failed"
	dodoc CHANGELOG README TODO
}

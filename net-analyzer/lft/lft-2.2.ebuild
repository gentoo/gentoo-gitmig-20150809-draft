# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/lft/lft-2.2.ebuild,v 1.7 2005/03/21 23:54:44 vanquirius Exp $

DESCRIPTION="Layer Four Traceroute: an advanced traceroute implementation"
HOMEPAGE="http://oppleman.com/lft/"
SRC_URI="http://mainnerve.com/lft/${P}.tar.gz"

LICENSE="MainNerve"
SLOT="0"
KEYWORDS="x86 ~amd64 ~ppc-macos"
IUSE=""

DEPEND="virtual/libpcap"

src_install() {
	einstall || die "make install failed"
	dodoc CHANGELOG README TODO
}

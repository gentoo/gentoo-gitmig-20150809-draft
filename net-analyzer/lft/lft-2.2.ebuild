# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/lft/lft-2.2.ebuild,v 1.6 2005/02/06 08:15:04 kito Exp $

DESCRIPTION="Layer Four Traceroute: an advanced traceroute implementation"
HOMEPAGE="http://www.mainnerve.com/lft/"
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

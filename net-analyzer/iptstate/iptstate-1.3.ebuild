# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/iptstate/iptstate-1.3.ebuild,v 1.2 2004/06/24 22:05:29 agriffis Exp $

S=${WORKDIR}/${P}
DESCRIPTION="IP Tables State displays states being kept by iptables in a top-like format"
SRC_URI="http://iptstate.phildev.net/${P}.tar.gz"
HOMEPAGE="http://iptstate.phildev.net"

DEPEND="sys-libs/ncurses"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 ~sparc"

src_compile() {
	make CXXFLAGS="${CXXFLAGS} -g -Wall" all
}

src_install() {
	make PREFIX=${D}/usr install
	dodoc README Changelog BUGS CONTRIB LICENSE WISHLIST
}

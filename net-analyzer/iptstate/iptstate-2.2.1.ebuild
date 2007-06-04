# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/iptstate/iptstate-2.2.1.ebuild,v 1.3 2007/06/04 19:12:53 gustavoz Exp $

DESCRIPTION="IP Tables State displays states being kept by iptables in a top-like format"
SRC_URI="http://www.phildev.net/iptstate/${P}.tar.bz2"
HOMEPAGE="http://www.phildev.net/iptstate/"

DEPEND="sys-libs/ncurses
	>=net-libs/libnetfilter_conntrack-0.0.50"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~hppa ~sparc ~x86"
IUSE=""

src_compile() {
	make CXXFLAGS="${CXXFLAGS} -g -Wall" all || die
}

src_install() {
	make PREFIX="${D}"/usr install || die
	dodoc README Changelog BUGS CONTRIB LICENSE WISHLIST
}

# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/iptstate/iptstate-1.2.1.ebuild,v 1.7 2003/02/13 13:41:59 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="IP Tables State displays states being kept by iptables in a top-like format"
SRC_URI="http://home.earthlink.net/~jaymzh666/iptstate/iptstate-${PV}.tar.gz"
HOMEPAGE="http://home.earthlink.net/~jaymzh666/iptstate/"

DEPEND="sys-libs/ncurses"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 sparc "

src_compile() {

	make CXXFLAGS="${CXXFLAGS} -g -Wall" all

}

src_install() {

	make PREFIX=${D}/usr install
	dodoc README Changelog BUGS CONTRIB LICENSE WISHLIST

}


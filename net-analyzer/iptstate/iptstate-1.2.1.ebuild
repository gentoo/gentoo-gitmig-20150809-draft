# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/iptstate/iptstate-1.2.1.ebuild,v 1.2 2002/07/11 06:30:43 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="IP Tables State displays states being kept by iptables in a top-like format"
SRC_URI="http://home.earthlink.net/~jaymzh666/iptstate/iptstate-${PV}.tar.gz"
HOMEPAGE="http://home.earthlink.net/~jaymzh666/iptstate/"

DEPEND="virtual/glibc sys-libs/ncurses"

src_compile() {

	make CXXFLAGS="${CXXFLAGS} -g -Wall" all

}

src_install() {

	make PREFIX=${D}/usr install
	dodoc README Changelog BUGS CONTRIB LICENSE WISHLIST

}


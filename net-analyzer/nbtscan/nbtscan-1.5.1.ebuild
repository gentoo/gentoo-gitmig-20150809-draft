# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nbtscan/nbtscan-1.5.1.ebuild,v 1.1 2004/03/29 13:46:38 mboman Exp $

S=${WORKDIR}/${P}a
DESCRIPTION="NBTscan is a program for scanning IP networks for NetBIOS name information"
SRC_URI="http://www.inetcat.org/software/${P}.tar.gz"
HOMEPAGE="http://www.inetcat.org/software/nbtscan.html"

DEPEND="virtual/glibc"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc "

src_compile() {
	./configure --host=${CHOST} --prefix=/usr  || die
	emake CFLAGS="${CFLAGS}" || die
}

src_install () {
	dobin nbtscan
	dodoc COPYING ChangeLog README
}

# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/sonypid/sonypid-1.7.ebuild,v 1.1 2003/05/13 19:04:40 hanno Exp $

S=${WORKDIR}/${P}
DESCRIPTION="sonypid - a tool to use the Sony Vaios jog-dial as a mouse-wheel"
HOMEPAGE="http://spop.free.fr/sonypi/"
SRC_URI="http://spop.free.fr/sonypi/${P}.tar.bz2"
IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 -ppc -sparc"

DEPEND="virtual/x11"

src_compile() {
	emake CFLAGS="${CFLAGS}" || die
}

src_install () {
	dobin sonypid
	dodoc AUTHORS CHANGES
}

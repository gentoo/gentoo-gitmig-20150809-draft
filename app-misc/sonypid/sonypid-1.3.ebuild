# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/sonypid/sonypid-1.3.ebuild,v 1.3 2002/12/09 04:17:42 manson Exp $

S=${WORKDIR}/${P}
DESCRIPTION="sonypid - a tool to use the Sony Vaios jog-dial as a mouse-wheel"
HOMEPAGE="http://www.alcove-labs.org/en/software/sonypi/"
SRC_URI="http://download.alcove-labs.org/software/sonypi/${P}.tar.bz2"

IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 -ppc -sparc "

DEPEND="virtual/x11"

src_compile() {
	emake CFLAGS="${CFLAGS} -I/usr/src/linux/include" || die
}

src_install () {
	dobin sonypid
}

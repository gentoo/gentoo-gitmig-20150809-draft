# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/sonypid/sonypid-1.2.ebuild,v 1.1 2002/10/13 19:46:40 hanno Exp $

S=${WORKDIR}/${P}
DESCRIPTION="sonypid - a tool to use the Sony Vaios jog-dial as a mouse-wheel"
HOMEPAGE="http://www.alcove-labs.org/en/software/sonypi/"
SRC_URI="http://download.alcove-labs.org/software/sonypi/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 -ppc -sparc -sparc64"

DEPEND="virtual/x11"
RDEPEND="${DEPEND}"

src_compile() {
	emake CFLAGS="${CFLAGS} -I/usr/src/linux/include" || die
}

src_install () {
	dobin sonypid
}

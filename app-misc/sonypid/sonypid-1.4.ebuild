# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/sonypid/sonypid-1.4.ebuild,v 1.2 2002/12/09 04:17:42 manson Exp $

S=${WORKDIR}/${P}
DESCRIPTION="sonypid - a tool to use the Sony Vaios jog-dial as a mouse-wheel"
HOMEPAGE="http://spop.free.fr/sonypi/"
SRC_URI="http://spop.free.fr/sonypi/${P}.tar.bz2"

IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 -ppc -sparc "

DEPEND="virtual/x11"

src_compile() {
	mv sonypid.c sonypid.c.orig
	sed -e 's#sonypi.h#linux/sonypi.h#g' sonypid.c.orig > sonypid.c
	emake CFLAGS="${CFLAGS} -I/usr/src/linux/include/" || die
}

src_install () {
	dobin sonypid
}

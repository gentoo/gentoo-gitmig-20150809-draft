# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-misc/zisofs-tools/zisofs-tools-1.0.3.ebuild,v 1.1 2002/06/06 19:21:42 woodchip Exp $

DESCRIPTION="User utilities for zisofs"
HOMEPAGE="http://www.kernel.org/pub/linux/utils/fs/zisofs/"
SRC_URI="http://www.kernel.org/pub/linux/utils/fs/zisofs/${P}.tar.bz2"

S=${WORKDIR}/${P}
DEPEND="virtual/glibc >=sys-libs/zlib-1.1.4"
LICENSE="GPL-2"
SLOT="0"

src_compile() {
	econf --host=${CHOST} || die
	make || die
}

src_install() {
	make INSTALLROOT=${D} install || die
	dodoc CHANGES COPYING INSTALL README
}

# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/zisofs-tools/zisofs-tools-1.0.4.ebuild,v 1.8 2004/06/20 08:05:55 pyrania Exp $

DESCRIPTION="User utilities for zisofs"
HOMEPAGE="http://www.kernel.org/pub/linux/utils/fs/zisofs/"
SRC_URI="mirror://kernel/linux/utils/fs/zisofs/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~alpha"
IUSE=""

DEPEND=">=sys-libs/zlib-1.1.4"

src_compile() {
	econf || die "econf failed"
	make || die
}

src_install() {
	make INSTALLROOT=${D} install || die
	dodoc CHANGES COPYING INSTALL README
}

# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/zisofs-tools/zisofs-tools-1.0.4-r1.ebuild,v 1.12 2004/07/16 09:09:20 gmsoft Exp $

inherit flag-o-matic

DESCRIPTION="User utilities for zisofs"
HOMEPAGE="http://www.kernel.org/pub/linux/utils/fs/zisofs/"
SRC_URI="mirror://kernel/linux/utils/fs/zisofs/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc sparc alpha arm amd64 hppa"
IUSE="static"

DEPEND=">=sys-libs/zlib-1.1.4"

src_compile() {
	use static && append-ldflags -static
	econf || die
	emake || die
}

src_install() {
	make INSTALLROOT=${D} install || die
	dodoc CHANGES INSTALL README
}

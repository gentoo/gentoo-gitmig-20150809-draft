# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/gsmlib/gsmlib-1.10.ebuild,v 1.8 2004/07/15 02:50:14 agriffis Exp $

IUSE=""
DESCRIPTION="Library and Applications to access GSM mobile phones"
SRC_URI="http://www.pxh.de/fs/gsmlib/download/${P}.tar.gz"
HOMEPAGE="http://www.pxh.de/fs/gsmlib/"

DEPEND="virtual/libc"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="x86 ppc sparc"

src_compile() {
	econf || die
	make || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS NEWS README
}

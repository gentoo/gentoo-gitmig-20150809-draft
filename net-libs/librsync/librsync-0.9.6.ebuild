# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/librsync/librsync-0.9.6.ebuild,v 1.9 2005/01/22 21:10:18 j4rg0n Exp $

DESCRIPTION="Flexible remote checksum-based differencing"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://librsync.sf.net/"

DEPEND="virtual/libc"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 sparc ~ppc ~amd64"
IUSE=""

src_compile() {
	./configure --prefix=/usr --host=${CHOST} --enable-shared || die
	emake || die
}

src_install () {
	make prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		install  || die

	dodoc COPYING NEWS INSTALL AUTHORS THANKS README TODO
}

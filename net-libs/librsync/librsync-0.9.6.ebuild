# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/librsync/librsync-0.9.6.ebuild,v 1.1 2003/08/17 14:41:58 mholzer Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Flexible remote checksum-based differencing"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://librsync.sf.net/"

DEPEND="virtual/glibc"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~x86 ~sparc"

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

# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/adns/adns-1.0.ebuild,v 1.11 2004/04/12 16:02:51 zx Exp $

DESCRIPTION="Advanced, easy to use, asynchronous-capable DNS client library and utilities"
SRC_URI="ftp://ftp.chiark.greenend.org.uk/users/ian/adns/${P}.tar.gz"
HOMEPAGE="http://www.chiark.greenend.org.uk/~ian/adns/"
SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="x86 ppc sparc "
IUSE=""
DEPEND=""
RDEPEND=""

src_compile() {
	./configure --prefix=/usr --host=${CHOST} || die
	make || die
}

src_install () {
	dodir /usr/{include,bin,lib}
	make prefix=${D}/usr install || die
	dodoc README GPL-vs-LGPL COPYING TODO
	dohtml *.html

	cd ${D}/usr/lib
	dosym libadns.so.1 /usr/lib/libadns.so
}


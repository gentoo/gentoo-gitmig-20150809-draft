# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/zlib/zlib-1.1.3-r3.ebuild,v 1.12 2003/06/22 05:10:31 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Standard (de)compression library"
SRC_URI="ftp://ftp.freesoftware.com/pub/infozip/zlib/${P}.tar.gz"
HOMEPAGE="http://www.gzip.org/zlib"
LICENSE="ZLIB"
KEYWORDS="x86 ppc sparc "
SLOT="0"

DEPEND="virtual/glibc"

src_compile() {

	./configure --shared --prefix=/usr || die
	emake || die

	make test || die

	./configure --prefix=/usr || die
	emake || die
}

src_install() {

	into /usr
	dodir /usr/include
	insinto /usr/include
	doins zconf.h zlib.h

	dolib libz.so.1.1.3
	( cd ${D}/usr/lib ; chmod 755 libz.so.* )
	dolib libz.a
	dosym libz.so.1.1.3 /usr/lib/libz.so
	dosym libz.so.1.1.3 /usr/lib/libz.so.1

	doman zlib.3
	dodoc FAQ README ChangeLog
	docinto txt
	dodoc algorithm.txt
}

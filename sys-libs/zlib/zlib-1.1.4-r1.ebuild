# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/zlib/zlib-1.1.4-r1.ebuild,v 1.6 2003/06/22 05:56:17 drobbins Exp $

inherit eutils flag-o-matic

S="${WORKDIR}/${P}"
DESCRIPTION="Standard (de)compression library"
SRC_URI="http://www.gzip.org/zlib/${P}.tar.bz2"
HOMEPAGE="http://www.gzip.org/zlib"

LICENSE="ZLIB"
KEYWORDS="amd64 x86 ppc sparc alpha mips hppa arm"
SLOT="0"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-gentoo.security.patch
}

src_compile() {
	./configure --shared --prefix=/usr || die

	append-flags -fPIC

	emake CFLAGS="${CFLAGS}" || die

	make test || die

	./configure --prefix=/usr || die
	emake || die
}

src_install() {
	into /usr
	dodir /usr/include
	insinto /usr/include
	doins zconf.h zlib.h

	dolib libz.so.${PV}
	( cd ${D}/usr/lib ; chmod 755 libz.so.* )
	dolib libz.a
	dosym libz.so.${PV} /usr/lib/libz.so
	dosym libz.so.${PV} /usr/lib/libz.so.1

	doman zlib.3
	dodoc FAQ README ChangeLog
	docinto txt
	dodoc algorithm.txt
}

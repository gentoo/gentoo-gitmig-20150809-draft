# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/zlib/zlib-1.2.1-r1.ebuild,v 1.5 2004/08/24 04:21:54 swegener Exp $

inherit eutils flag-o-matic

DESCRIPTION="Standard (de)compression library"
SRC_URI="http://www.gzip.org/zlib/${P}.tar.bz2"
HOMEPAGE="http://www.gzip.org/zlib"

LICENSE="ZLIB"
KEYWORDS="~amd64 ~x86 ~ppc ~sparc ~alpha ~mips ~hppa ~ia64 ~ppc64"
SLOT="0"
IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}

	cd ${S}
	# Make sure we link with glibc at all times
	epatch ${FILESDIR}/${P}-glibc.patch
	# Needed for Alpha and prelink
	epatch ${FILESDIR}/${P}-build-fPIC.patch
	# Only export global symbols, bug #32764
	epatch ${FILESDIR}/${P}-mapfile.patch
}

src_compile() {
	./configure --shared --prefix=/usr --libdir=/lib || die
	emake || die
	make test || die

	./configure --prefix=/usr --libdir=/lib || die
	emake || die
}

src_install() {
	einstall libdir=${D}/lib || die
	into /usr
	dodir /usr/include
	insinto /usr/include
	doins zconf.h zlib.h

	doman zlib.3
	dodoc FAQ README ChangeLog
	docinto txt
	dodoc algorithm.txt

	into /
	dolib libz.so.${PV}
	( cd ${D}/lib ; chmod 755 libz.so.* )
	dolib libz.a
	dosym libz.so.${PV} /lib/libz.so
	dosym libz.so.${PV} /lib/libz.so.1

}

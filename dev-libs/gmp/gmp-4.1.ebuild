# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/gmp/gmp-4.1.ebuild,v 1.8 2003/03/15 14:48:09 azarah Exp $

DESCRIPTION="Library for arithmetic on arbitrary precision integers, rational numbers, and floating-point numbers"
SRC_URI="ftp://prep.ai.mit.edu/gnu/gmp/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/gmp/gmp.html"
KEYWORDS="x86 sparc "                                                                  
SLOT="0"    
LICENSE="LGPL-2"
DEPEND="virtual/glibc
	~sys-devel/m4-1.4"
RDEPEND="virtual/glibc"

src_compile() {                           
	./configure \
		--build=${CHOST} \
		--host=${CHOST} \
		--target=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--sysconfdir=/etc \
		--localstatedir=/var/state/gmp \
		--enable-cxx \
		--enable-mpbsd \
		--enable-mpfr || die "configure failed"

	emake || die "make failed"
}

src_install() {                               
	make DESTDIR=${D} install || die

	dodoc AUTHORS ChangeLog COPYING* NEWS README
	dodoc doc/configuration doc/isa_abi_headache
	dohtml -r doc
}

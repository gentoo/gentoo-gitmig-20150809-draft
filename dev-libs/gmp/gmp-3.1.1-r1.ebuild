# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/gmp/gmp-3.1.1-r1.ebuild,v 1.14 2003/09/06 22:29:24 msterret Exp $

DESCRIPTION="Library for arithmetic on arbitrary precision integers, rational numbers, and floating-point numbers"
HOMEPAGE="http://www.gnu.org/software/gmp/gmp.html"
SRC_URI="ftp://prep.ai.mit.edu/gnu/gmp/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="x86 sparc"

DEPEND="virtual/glibc
	~sys-devel/m4-1.4"
RDEPEND="virtual/glibc"

src_compile() {
	./configure --host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--enable-mpfr \
		--enable-mpbsd \
		|| die
	make || die
}

src_install() {
	make prefix=${D}/usr infodir=${D}/usr/share/info install || die

	dodoc AUTHORS ChangeLog COPYING* NEWS README
	dodoc doc/assembly_code doc/configuration
	dodoc doc/isa_abi_headache doc/multiplication
	dohtml -r doc
}

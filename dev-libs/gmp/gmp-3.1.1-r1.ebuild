# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-libs/gmp/gmp-3.1.1-r1.ebuild,v 1.8 2002/08/14 11:52:27 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Library for arithmetic on arbitrary precision integers, rational numbers, and floating-point numbers"
SRC_URI="ftp://prep.ai.mit.edu/gnu/gmp/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/gmp/gmp.html"
KEYWORDS="x86 sparc sparc64"                                                                  
SLOT="0"    
LICENSE="LGPL-2"
DEPEND="virtual/glibc
	>=sys-devel/m4-1.4o"
RDEPEND="virtual/glibc"

src_compile() {                           
	./configure --host=${CHOST}					\
		    --prefix=/usr					\
		    --infodir=/usr/share/info				\
		    --enable-mpfr					\
		    --enable-mpbsd
	assert

	make || die
}

src_install() {                               
	make prefix=${D}/usr infodir=${D}/usr/share/info install || die

	dodoc AUTHORS ChangeLog COPYING* NEWS README
	dodoc doc/assembly_code doc/configuration
	dodoc doc/isa_abi_headache doc/multiplication
	dohtml -r doc
}

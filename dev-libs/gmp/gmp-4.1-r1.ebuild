# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-libs/gmp/gmp-4.1-r1.ebuild,v 1.7 2002/08/14 11:52:27 murphy Exp $

DESCRIPTION="Library for arithmetic on arbitrary precision integers, rational numbers, and floating-point numbers"
SRC_URI="ftp://prep.ai.mit.edu/gnu/gmp/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/gmp/gmp.html"

KEYWORDS="x86 ppc sparc sparc64"                                                                  
SLOT="0"    
LICENSE="LGPL-2"

DEPEND=">=sys-devel/m4-1.4p"



src_unpack() {
	unpack ${A}
	cd ${S}
	patch < ${FILESDIR}/randraw.c.41.diff
}

src_compile() {                           
	econf \
		--localstatedir=/var/state/gmp \
		--enable-cxx \
		--enable-mpbsd \
		--enable-mpfr || die "configure failed"

	make || die "make failed"
}

src_install() {                               
	make DESTDIR=${D} install || die

	dodoc AUTHORS ChangeLog COPYING* NEWS README
	dodoc doc/configuration doc/isa_abi_headache
	dohtml -r doc
}

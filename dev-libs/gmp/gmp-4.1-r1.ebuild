# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/gmp/gmp-4.1-r1.ebuild,v 1.14 2003/03/15 14:48:09 azarah Exp $

DESCRIPTION="Library for arithmetic on arbitrary precision integers, rational numbers, and floating-point numbers"
SRC_URI="ftp://prep.ai.mit.edu/gnu/gmp/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/gmp/gmp.html"

KEYWORDS="x86 ppc sparc alpha"
SLOT="0"    
LICENSE="LGPL-2"

DEPEND="~sys-devel/m4-1.4"



src_unpack() {
	unpack ${A}
	cd ${S}
	patch < ${FILESDIR}/randraw.c.41.diff
}

src_compile() {                           
	if [ "${ARCH}" = "sparc" ]
	then
		econf \
			--localstatedir=/var/state/gmp \
			--enable-cxx \
			--enable-mpbsd || die "configure failed"
	else
	        econf \
        	        --localstatedir=/var/state/gmp \
               	 	--enable-cxx \
         	        --enable-mpbsd \
         	        --enable-mpfr || die "configure failed"
	fi

	make || die "make failed"
}

src_install() {                               
	make DESTDIR=${D} install || die

	dodoc AUTHORS ChangeLog COPYING* NEWS README
	dodoc doc/configuration doc/isa_abi_headache
	dohtml -r doc
}

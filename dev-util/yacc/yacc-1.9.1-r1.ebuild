# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-util/yacc/yacc-1.9.1-r1.ebuild,v 1.10 2002/08/16 04:04:42 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Yacc"
SRC_URI="ftp://metalab.unc.edu/pub/Linux/devel/compiler-tools/${P}.tar.Z"
HOMEPAGE="http://dinosaur.compilertools.net/#yacc"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc sparc sparc64"

DEPEND="virtual/glibc"

src_unpack () {
	unpack ${A}
	cd ${S}
	cp Makefile Makefile.orig
	sed -e "s:-O:${CFLAGS}:" Makefile.orig > Makefile
}
src_compile() {                           
	make clean || die
	make || die
}

src_install() {                               
	into /usr
	dobin yacc
	doman yacc.1
	dodoc 00README* ACKNOWLEDGEMENTS NEW_FEATURES NO_WARRANTY NOTES README*
}

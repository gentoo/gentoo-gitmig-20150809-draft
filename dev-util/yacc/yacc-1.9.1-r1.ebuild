# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/yacc/yacc-1.9.1-r1.ebuild,v 1.24 2004/03/13 01:44:56 vapier Exp $

DESCRIPTION="Yacc"
HOMEPAGE="http://dinosaur.compilertools.net/#yacc"
SRC_URI="ftp://metalab.unc.edu/pub/Linux/devel/compiler-tools/${P}.tar.Z"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc ppc64 sparc alpha mips hppa amd64 ia64 s390"

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
	dobin yacc || die
	doman yacc.1
	dodoc 00README* ACKNOWLEDGEMENTS NEW_FEATURES NO_WARRANTY NOTES README*
}

# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/sqlite/sqlite-2.8.0.ebuild,v 1.1 2003/04/22 10:21:59 robbat2 Exp $

S=${WORKDIR}/sqlite
DESCRIPTION="SQLite: An SQL Database Engine in a C Library."
SRC_URI="http://www.hwaci.com/sw/sqlite/${P}.tar.gz"
HOMEPAGE="http://www.hwaci.com/sw/sqlite/"
DEPEND="virtual/glibc
	dev-lang/tcl"
SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc sparc "

src_compile() {
	econf || die
	
	emake || die
	make doc || die
}

src_install () {
	dodir /usr/{bin,include,lib}
	
	einstall || die

	dobin lemon
	dodoc README VERSION 
	doman sqlite.1
	docinto html
	dohtml doc/*.html doc/*.txt doc/*.png
}


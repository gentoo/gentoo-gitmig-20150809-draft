# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-db/sqlite/sqlite-2.6.3.ebuild,v 1.1 2002/08/19 02:03:39 rphillips Exp $

S=${WORKDIR}/sqlite
DESCRIPTION="SQLite: An SQL Database Engine in a C Library."
SRC_URI="http://www.hwaci.com/sw/sqlite/${P}.tar.gz"
HOMEPAGE="http://www.hwaci.com/sw/sqlite/"
DEPEND="virtual/glibc
	dev-lang/tcl"
SLOT="0"
LICENSE="as-is"
KEYWORDS="x86"

src_compile() {

	./configure --host=${CHOST} \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--sysconfdir=/etc || die
		
	emake || die
	make doc || die
}

src_install () {
	
	dodir /usr/{bin,include,lib}
	
	make prefix=${D}/usr \
	     mandir=${D}/usr/share/man \
	     infodir=${D}/usr/share/info \
	     sysconfdir=${D}/etc \
	     install || die

	dobin lemon

	dodoc README VERSION 
	docinto html
	dohtml doc/*.html doc/*.txt doc/*.png
}


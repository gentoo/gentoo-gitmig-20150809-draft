# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/sqlite/sqlite-2.8.2.ebuild,v 1.1 2003/05/20 18:18:23 robbat2 Exp $

S=${WORKDIR}/sqlite
DESCRIPTION="SQLite: An SQL Database Engine in a C Library."
SRC_URI="http://www.hwaci.com/sw/sqlite/${P}.tar.gz"
HOMEPAGE="http://www.hwaci.com/sw/sqlite/"
DEPEND="virtual/glibc
	dev-lang/tcl"
SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc sparc ~alpha ~mips ~arm ~hppa"

src_compile() {
	local myconf
	myconf="--enable-incore-db --enable-tempdb-in-ram"
	myconf="${myconf} `use_with nls utf8`"
	econf ${myconf} || die
	emake all doc || die
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


# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/sqlite/sqlite-3.0.8.ebuild,v 1.1 2004/10/29 21:13:33 arj Exp $

IUSE="nls"

S=${WORKDIR}/sqlite
DESCRIPTION="SQLite: An SQL Database Engine in a C Library."
SRC_URI="http://www.sqlite.org/${P}.tar.gz"
HOMEPAGE="http://www.sqlite.org"
DEPEND="virtual/libc
	dev-lang/tcl"
SLOT="3"
LICENSE="as-is"

KEYWORDS="~x86"

src_compile() {
	# sqlite includes a doc directory making it impossible to generate docs, 
	# which are very important to people adding support for sqlite3 to their
	# programs.
	rm -rf doc/

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

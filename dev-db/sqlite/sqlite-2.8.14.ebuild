# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/sqlite/sqlite-2.8.14.ebuild,v 1.3 2004/08/03 19:07:16 agriffis Exp $

IUSE="nls"

S=${WORKDIR}/sqlite
DESCRIPTION="SQLite: An SQL Database Engine in a C Library."
SRC_URI="http://www.sqlite.org/${P}.tar.gz"
HOMEPAGE="http://www.sqlite.org"
DEPEND="virtual/libc
	dev-lang/tcl"
SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~mips ~hppa ~ppc64 ~amd64 ia64"

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

# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/sqlite/sqlite-2.8.15.ebuild,v 1.8 2004/11/07 09:29:58 kumba Exp $

inherit eutils

IUSE="nls"

S=${WORKDIR}/sqlite
DESCRIPTION="SQLite: An SQL Database Engine in a C Library."
SRC_URI="http://www.sqlite.org/${P}.tar.gz"
HOMEPAGE="http://www.sqlite.org"
DEPEND="virtual/libc
	dev-lang/tcl"
SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 ppc ~sparc ~alpha ~arm mips hppa ~ppc64 ~amd64 ppc-macos"

src_unpack() {

	unpack ${A}

	use hppa && epatch ${FILESDIR}/${P}-alignement-fix.patch

}

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

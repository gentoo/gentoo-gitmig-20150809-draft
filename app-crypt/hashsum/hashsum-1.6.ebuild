# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/hashsum/hashsum-1.6.ebuild,v 1.4 2004/10/21 19:37:52 hanno Exp $

DESCRIPTION="Command line tool for advanced hashing algorithms"
HOMEPAGE="http://www.certainkey.com/resources/hashsum.php"
SRC_URI="http://www.certainkey.com/resources/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE="doc"

DEPEND="virtual/libc"

S="${WORKDIR}/${PN}"

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dobin hashsum || die "dobin failed"
	dosym /usr/bin/hashsum /usr/bin/sha256sum
	dosym /usr/bin/hashsum /usr/bin/sha384sum
	dosym /usr/bin/hashsum /usr/bin/sha512sum
	dosym /usr/bin/hashsum /usr/bin/ripemd160sum
	# There are a heap of manpages. One for every sourcefile.
	# But currently I see no other way but to use them all
	# Maybe it should depend on whether USE="doc" is set or not
	doman hashsum_docs/man/man3/*.3
	if use doc ; then
		insinto /usr/doc/${PF}/latex
		doins hashsum_docs/latex/*.*
		insinto /usr/doc/${PF}/html
		doins hashsum_docs/html/*.*
		insinto /usr/doc/${PF}/rtf
		doins hashsum_docs//rtf/*.*
	fi
}

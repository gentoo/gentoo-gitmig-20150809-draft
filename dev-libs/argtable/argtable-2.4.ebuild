# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/argtable/argtable-2.4.ebuild,v 1.1 2005/02/01 14:49:43 ka0ttic Exp $

inherit eutils

DESCRIPTION="An ANSI C library for parsing GNU-style command-line options with minimal fuss"
HOMEPAGE="http://argtable.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc debug"

RDEPEND="virtual/libc"

S="${WORKDIR}/argtable2"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-fix-makefile.diff
}

src_compile() {
	econf $(use_enable debug) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	dodoc history.txt readme.txt

	if use doc ; then
		cd ${S}/doc
		dohtml *.html *.gif
		dodoc *.pdf *.ps

		cd ${S}/example
		docinto examples
		dodoc Makefile *.[ch] README.txt
	fi
}

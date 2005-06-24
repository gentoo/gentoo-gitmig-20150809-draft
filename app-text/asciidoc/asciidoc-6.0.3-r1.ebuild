# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/asciidoc/asciidoc-6.0.3-r1.ebuild,v 1.3 2005/06/24 21:02:45 agriffis Exp $

inherit eutils

DESCRIPTION="AsciiDoc is a text document format for writing short documents,
articles, books and UNIX man pages."
HOMEPAGE="http://www.methods.co.nz/asciidoc/"
SRC_URI="http://www.methods.co.nz/asciidoc/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~x86"
IUSE=""

DEPEND="virtual/python"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${PN}-name.patch
}

src_install() {

	newbin asciidoc.py asciidoc

	insopts -m664
	insinto /etc/${PN}
	doins *.conf
	doins -r filters

	dodoc BUGS CHANGELOG COPYRIGHT README
	dodir /usr/share/doc/${PF}/examples
	cp -r ${S}/examples ${D}/usr/share/doc/${PF}
	doman ${S}/doc/asciidoc.1
}

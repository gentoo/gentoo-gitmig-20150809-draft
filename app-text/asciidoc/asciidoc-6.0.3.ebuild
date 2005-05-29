# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/asciidoc/asciidoc-6.0.3.ebuild,v 1.1 2005/05/29 04:06:20 usata Exp $

DESCRIPTION="AsciiDoc is a text document format for writing short documents,
articles, books and UNIX man pages."
HOMEPAGE="http://www.methods.co.nz/asciidoc/"
SRC_URI="http://www.methods.co.nz/asciidoc/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/python"

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

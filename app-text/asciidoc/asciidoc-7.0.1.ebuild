# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/asciidoc/asciidoc-7.0.1.ebuild,v 1.6 2005/08/23 03:59:56 agriffis Exp $

DESCRIPTION="A text document format for writing short documents, articles, books and UNIX man pages"
HOMEPAGE="http://www.methods.co.nz/asciidoc/"
SRC_URI="http://www.methods.co.nz/asciidoc/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc x86"
IUSE=""

DEPEND=">=virtual/python-2.3"

src_install() {
	# Main binary
	newbin asciidoc.py asciidoc

	# Conf. files
	insopts -m664
	insinto /etc/asciidoc
	doins *.conf

	# Filters
	insinto /etc/asciidoc/filters
	doins filters/code-filter.conf filters/code-filter.py
	dodoc filters/*.txt

	# Stylesheets
	insinto /etc/asciidoc/stylesheets
	doins stylesheets/*.css

	# Shared files
	dodir /usr/share/asciidoc
	for dir in doc examples images stylesheets; do
		cp -R $dir ${D}/usr/share/asciidoc
	done

	# Misc. documentation
	dodoc BUGS CHANGELOG COPYRIGHT README
	dohtml -r doc/*
	doman doc/asciidoc.1
}

# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/asciidoc/asciidoc-7.0.1-r1.ebuild,v 1.2 2005/08/13 10:29:29 r3pek Exp $

DESCRIPTION="A text document format for writing short documents, articles, books and UNIX man pages"
HOMEPAGE="http://www.methods.co.nz/asciidoc/"
SRC_URI="http://www.methods.co.nz/asciidoc/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=">=virtual/python-2.3"

src_install() {
	# Main binary
	newbin asciidoc.py asciidoc

	# Conf. files
	insinto /etc/asciidoc
	doins *.conf

	# Shared files
	dodir /usr/share/asciidoc
	for dir in doc examples filters images stylesheets; do
		cp -R $dir ${D}/usr/share/asciidoc
	done

	# Filters
	dodir /etc/asciidoc/filters
	chmod 0755 ${D}/usr/share/asciidoc/filters/*.py
	for f in code-filter.{conf,py}; do
		dosym /usr/share/asciidoc/filters/${f} /etc/asciidoc/filters/${f}
	done

	# Stylesheets
	insinto /etc/asciidoc/stylesheets
	doins stylesheets/*.css

	# Misc. documentation
	dodoc BUGS CHANGELOG COPYRIGHT README
	dohtml -r doc/*
	doman doc/asciidoc.1
}

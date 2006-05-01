# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/asciidoc/asciidoc-7.0.4.ebuild,v 1.5 2006/05/01 11:04:10 corsair Exp $

DESCRIPTION="A text document format for writing short documents, articles, books and UNIX man pages"
HOMEPAGE="http://www.methods.co.nz/asciidoc/"
SRC_URI="http://www.methods.co.nz/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 hppa ~ia64 ~mips ppc ~ppc-macos ppc64 sparc ~x86"
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
	for dir in doc docbook-xsl examples filters images stylesheets; do
		cp -R $dir ${D}/usr/share/asciidoc
	done
	# note: we write some symlinks' their targets here, because we
	# otherwise would end up with dead symlinks (bug #107530)
	for f in {README,CHANGELOG}.txt; do
		cp -f ${f} ${D}/usr/share/asciidoc/examples/website/${f}
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
	dodoc docbook-xsl/asciidoc-docbook-xsl.txt
	dohtml -r doc/*
	doman doc/asciidoc.1
}

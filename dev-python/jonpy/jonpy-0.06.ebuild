# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/jonpy/jonpy-0.06.ebuild,v 1.1 2004/12/20 21:52:00 port001 Exp $

inherit distutils

IUSE=""

HOMEPAGE="http://jonpy.sourceforge.net/"
DESCRIPTION="Powerful multi-threaded object-oriented CGI/FastCGI/mod_python/html-templating facilities"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86"

DEPEND=">=dev-lang/python-2.2"
RDEPEND="${DEPEND}"

src_install() {
	distutils_src_install

	dodir /usr/share/${P}/wt-examples
	insinto /usr/share/${P}/wt-examples
	doins ${S}/example/printenv.html ${S}/example/wt/printenv.html.py
	dodir /usr/share/${P}/wt-examples/cgi-bin
	insinto /usr/share/${P}/wt-examples/cgi-bin
	doins ${S}/example/cgi-bin/wt.py

	dodir /usr/share/doc/${P}/html/
	insinto /usr/share/doc/${P}/html
	for file in `ls ${S}/doc/`; do
		doins ${S}/doc/${file}
	done

	dodoc LICENCE README
}

pkg_postinst() {
	echo
	einfo "Examples for the 'wt' module have been installed in /usr/share/${P}/wt-examples"
	echo
}

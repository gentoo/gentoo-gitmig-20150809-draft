# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/jonpy/jonpy-0.06.ebuild,v 1.3 2005/05/31 01:04:11 port001 Exp $

inherit distutils

IUSE=""

HOMEPAGE="http://jonpy.sourceforge.net/"
DESCRIPTION="Powerful multi-threaded object-oriented CGI/FastCGI/mod_python/html-templating facilities"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86"

DEPEND=">=dev-lang/python-2.2"
RDEPEND="${DEPEND}"

src_install() {
	distutils_src_install

	insinto /usr/share/${P}/wt-examples
	doins ${S}/example/printenv.html ${S}/example/wt/printenv.html.py
	insinto /usr/share/${P}/wt-examples/cgi-bin
	doins ${S}/example/cgi-bin/wt.py

	for file in `ls ${S}/doc/`; do
		dohtml ${S}/doc/${file}
	done

	dodoc LICENCE README
}

pkg_postinst() {
	echo
	einfo "Examples for the 'wt' module have been installed in /usr/share/${P}/wt-examples"
	echo
}

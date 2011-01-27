# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/html2text/html2text-2.39.ebuild,v 1.3 2011/01/27 21:43:57 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit python

DESCRIPTION="Python script that converts HTML to Markdown syntax."
HOMEPAGE="http://www.aaronsw.com/2002/html2text/ http://pypi.python.org/pypi/html2text"
SRC_URI="http://www.aaronsw.com/2002/${PN}/${P}.py"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-python/feedparser"

src_unpack() {
	:
}

src_install() {
	my_install() {
		insinto "$(python_get_sitedir)" || return 1
		newins "${DISTDIR}"/${P}.py ${PN}.py || return 1
	}
	python_execute_function my_install
}

pkg_postinst() {
	python_mod_optimize ${PN}.py
}

pkg_postrm() {
	python_mod_cleanup ${PN}.py
}

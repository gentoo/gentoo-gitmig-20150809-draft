# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/html2text/html2text-2.39.ebuild,v 1.1 2010/11/25 00:33:41 sping Exp $

EAPI="2"

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit python

DESCRIPTION="Python script that converts HTML to Markdown syntax."
HOMEPAGE="http://www.aaronsw.com/2002/html2text/"
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
		insinto "$(python_get_sitedir)"
		newins "${DISTDIR}"/${P}.py ${PN}.py || die
	}
	python_execute_function my_install
}

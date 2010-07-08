# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-yadis/python-yadis-1.1.0.ebuild,v 1.4 2010/07/08 17:05:54 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
PYTHON_USE_WITH="xml"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils eutils

DESCRIPTION="Yadis service discovery library."
HOMEPAGE="http://www.openidenabled.com/yadis/libraries/python/"
SRC_URI="http://www.openidenabled.com/resources/downloads/python-openid/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-python/elementtree
	dev-python/python-urljr"
DEPEND="${RDEPEND}
	test? ( >=dev-python/pyflakes-0.2.1 )"

PYTHON_MODNAME="yadis"

src_prepare() {
	# Fix broken test.
	epatch "${FILESDIR}/${P}-gentoo-test.patch"
}

src_test() {
	testing() {
		./admin/runtests
	}
	python_execute_function testing

	einfo "The pyflake output about XML* redefinitions can be safely ignored"
}

# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/sphinxcontrib-issuetracker/sphinxcontrib-issuetracker-0.9.ebuild,v 1.4 2012/03/31 03:54:10 floppym Exp $

EAPI="4"
SUPPORT_PYTHON_ABIS="1"
PYTHON_DEPEND="2:2.6"
RESTRICT_PYTHON_ABIS="2.5 3.*"
PYTHON_TESTS_RESTRICTED_ABIS="*-jython *-pypy-*"
DISTUTILS_SRC_TEST="py.test"

inherit distutils

DESCRIPTION="Extension to sphinx to create links to issue trackers"
HOMEPAGE="http://packages.python.org/sphinxcontrib-issuetracker/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=">=dev-python/sphinx-1.0"
DEPEND="${RDEPEND}
	dev-python/setuptools
	test? (
		dev-python/mock
		dev-python/pyquery
	)"

PYTHON_MODNAME="${PN/-//}.py"

src_prepare() {
	distutils_src_prepare

	# Tests from tests/test_stylesheet.py require dev-python/PyQt4[X,webkit]
	# and virtualx.eclass.
	rm tests/test_stylesheet.py || die
}

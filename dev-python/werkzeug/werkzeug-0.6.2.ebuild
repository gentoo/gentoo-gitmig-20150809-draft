# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/werkzeug/werkzeug-0.6.2.ebuild,v 1.6 2010/12/26 15:51:48 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

MY_P="Werkzeug-${PV}"

DESCRIPTION="Collection of various utilities for WSGI applications"
HOMEPAGE="http://werkzeug.pocoo.org/ http://pypi.python.org/pypi/Werkzeug"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="test"

RDEPEND=""
DEPEND="dev-python/setuptools
	app-arch/unzip
	test? (
		dev-python/lxml
		dev-python/pytest
		dev-python/simplejson
	)"

S="${WORKDIR}/${MY_P}"

DOCS="CHANGES"

src_test() {
	distutils_src_test -e '^test_app$'
}

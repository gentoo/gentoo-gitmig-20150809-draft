# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/werkzeug/werkzeug-0.2.ebuild,v 1.2 2008/03/15 23:23:23 dev-zero Exp $

NEED_PYTHON="2.4"

inherit distutils

MY_P="Werkzeug-${PV}"

DESCRIPTION="Collection of various utilities for WSGI applications"
HOMEPAGE="http://werkzeug.pocoo.org/"
SRC_URI="http://pypi.python.org/packages/source/W/Werkzeug/${MY_P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=""
DEPEND=">=dev-python/setuptools-0.6_rc5
	test? ( dev-python/py
		dev-python/lxml
		dev-python/simplejson )"

S="${WORKDIR}/${MY_P}"

DOCS="CHANGES"

src_test() {
	distutils_python_version
	# path gets set correctly in conftest.py
	cd tests
	py.test || die "tests failed"
}

# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/werkzeug/werkzeug-0.7.1.ebuild,v 1.1 2011/07/28 19:05:51 rafaelmartins Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

MY_PN="Werkzeug"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Collection of various utilities for WSGI applications"
HOMEPAGE="http://werkzeug.pocoo.org/ http://pypi.python.org/pypi/Werkzeug"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="test"

RDEPEND="dev-python/simplejson"
DEPEND="dev-python/setuptools
	test? ( dev-python/lxml )"

S="${WORKDIR}/${MY_P}"

DOCS="CHANGES"

src_test() {
	distutils_src_test -e '^test_app$' tests tests/contrib
}

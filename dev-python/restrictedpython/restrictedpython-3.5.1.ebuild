# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/restrictedpython/restrictedpython-3.5.1.ebuild,v 1.4 2010/01/22 18:59:47 ranger Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

MY_PN="RestrictedPython"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="RestrictedPython provides a restricted execution environment for Python, e.g. for running untrusted code."
HOMEPAGE="http://pypi.python.org/pypi/RestrictedPython"
SRC_URI="http://pypi.python.org/packages/source/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="test"

DEPEND="dev-python/setuptools
	test? ( dev-python/nose net-zope/zope-testing )"
RDEPEND=""
RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="${MY_PN}"
DOCS="CHANGES.txt src/RestrictedPython/README.txt"

src_test() {
	testing() {
		nosetests-${PYTHON_ABI}
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	# Don't install tests.
	rm -fr "${D}"usr/$(get_libdir)/python*/site-packages/RestrictedPython/tests
}

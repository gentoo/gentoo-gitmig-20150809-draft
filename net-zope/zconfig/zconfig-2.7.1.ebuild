# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zconfig/zconfig-2.7.1.ebuild,v 1.2 2009/11/06 16:51:01 volkmar Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils eutils

MY_PN="ZConfig"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Structured Configuration Library"
HOMEPAGE="http://pypi.python.org/pypi/ZConfig"
SRC_URI="http://pypi.python.org/packages/source/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~amd64 ~ppc"
IUSE="test"

DEPEND="dev-python/setuptools
	test? ( dev-python/nose net-zope/zope-testing )"
RDEPEND=""
RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="${MY_PN}"
DOCS="NEWS.txt README.txt"

src_prepare() {
	distutils_src_prepare
	epatch "${FILESDIR}/${P}-fix_tests.patch"
}

src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib" nosetests-${PYTHON_ABI}
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	# Don't install tests.
	rm -fr "${D}"usr/$(get_libdir)/python*/site-packages/ZConfig/tests
}

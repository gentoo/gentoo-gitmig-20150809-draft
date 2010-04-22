# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pywavelets/pywavelets-0.2.0.ebuild,v 1.1 2010/04/22 20:14:30 bicatali Exp $

EAPI=2
SUPPORT_PYTHON_ABIS="1"
inherit distutils

MY_PN="${PN/pyw/PyW}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Python module for discrete, stationary, and packet wavelet transforms."
HOMEPAGE="http://www.pybytes.com/pywavelets/"
SRC_URI="http://cheeseshop.python.org/packages/source/${MY_P:0:1}/${MY_PN}/${MY_P}.tar.bz2"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples test"
DEPEND="dev-python/cython
	test? ( dev-python/numpy )"
RDEPEND="dev-python/numpy"
RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${MY_P}"

src_test() {
	testing() {
		PYTHONPATH="$(ls -d build-${PYTHON_ABI}/lib.*)"
			"$(PYTHON)" tests/test_perfect_reconstruction.py
	}
	python_execute_function testing
}

src_install () {
	DOCS="CHANGES.txt THANKS.txt"
	distutils_src_install
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins demo/* || die
	fi
	use doc && dohtml -r doc/build/html/*
}

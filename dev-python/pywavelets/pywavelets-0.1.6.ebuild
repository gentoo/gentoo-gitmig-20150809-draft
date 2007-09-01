# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pywavelets/pywavelets-0.1.6.ebuild,v 1.2 2007/09/01 22:10:05 bicatali Exp $

NEED_PYTHON=2.4

inherit distutils

MY_PN="${PN/pyw/PyW}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Python module for discrete, stationary, and packet wavelet transforms."
HOMEPAGE="http://www.pybytes.com/pywavelets/"
SRC_URI="http://cheeseshop.python.org/packages/source/${MY_P:0:1}/${MY_PN}/${MY_P}.zip"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"
DEPEND="app-arch/unzip"
RDEPEND=">=dev-python/numpy-1.0.3.1"

S="${WORKDIR}/${MY_P}"

src_test() {
	cd "${S}"/build/lib*
	PYTHONPATH=. \
		${python} "${S}"/tests/test_perfect_reconstruction.py \
		|| die "test failed"
}

src_install () {
	DOCS="CHANGES.txt THANKS.txt"
	distutils_src_install
	insinto /usr/share/doc/${PF}/demo
	doins demo/*
	use doc && dohtml -r doc/html/*
}

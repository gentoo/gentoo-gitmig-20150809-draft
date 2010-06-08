# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mpmath/mpmath-0.15.ebuild,v 1.2 2010/06/08 00:39:54 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
DISTUTILS_SRC_TEST="py.test"

inherit distutils

DESCRIPTION="A python library for arbitrary-precision floating-point arithmetic"
HOMEPAGE="http://code.google.com/p/mpmath/ http://pypi.python.org/pypi/mpmath"
SRC_URI="http://mpmath.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples gmp"

RDEPEND="gmp? ( dev-python/gmpy )"
DEPEND="doc? ( dev-python/sphinx )"

DOCS="CHANGES"

src_compile() {
	distutils_src_compile
	if use doc; then
		cd doc
		"$(PYTHON -f)" build.py
	fi
}

src_test() {
	cd mpmath/tests
	distutils_src_test
}

src_install() {
	distutils_src_install

	if use doc; then
		cd doc
		dohtml -r build/*
		cd ..
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins demo/*
	fi
}

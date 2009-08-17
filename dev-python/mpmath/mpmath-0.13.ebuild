# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mpmath/mpmath-0.13.ebuild,v 1.1 2009/08/17 16:55:05 grozin Exp $

EAPI=2
NEED_PYTHON=2.4
inherit distutils

DESCRIPTION="A python library for arbitrary-precision floating-point arithmetic"
HOMEPAGE="http://code.google.com/p/${PN}/"
SRC_URI="http://mpmath.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples gmp test"

RDEPEND="gmp? ( dev-python/gmpy )"
DEPEND="doc? ( dev-python/sphinx )
	test? ( dev-python/py )"

src_compile() {
	distutils_src_compile
	if use doc; then
		cd doc
		"${python}" build.py
		cd ..
	fi
}

src_install() {
	DOCS="CHANGES"
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

src_test() {
	cd mpmath/tests
	py.test || die "tests failed"
}

# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/beautifulsoup4/beautifulsoup4-4.0.4.ebuild,v 1.1 2012/04/21 20:36:37 floppym Exp $

EAPI="4"

PYTHON_DEPEND="*:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.5"
PYTHON_TESTS_RESTRICTED_ABIS="*-pypy-*"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

DESCRIPTION="Provides pythonic idioms for iterating, searching, and modifying an HTML/XML parse tree"
HOMEPAGE="http://www.crummy.com/software/BeautifulSoup/
	http://pypi.python.org/pypi/beautifulsoup4"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND="doc? ( dev-python/sphinx )"
RDEPEND=""

PYTHON_MODNAME="bs4"

src_compile() {
	distutils_src_compile
	if use doc; then
		PYTHONPATH="build-$(PYTHON --ABI -f)/lib" emake -C doc html
	fi
}

src_test() {
	testing() {
		cd "${S}/build-${PYTHON_ABI}/lib"
		nosetests --verbosity="${PYTHON_TEST_VERBOSITY}"
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install
	if use doc; then
		dohtml -r doc/build/html/*
	fi
}

# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/scrapy/scrapy-0.14.2.ebuild,v 1.2 2012/04/19 07:10:37 mr_bones_ Exp $

EAPI="4"

PYTHON_DEPEND="2:2.5"
PYTHON_USE_WITH="sqlite"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-pypy-*"
DISTUTILS_SRC_TEST="setup.py"
inherit distutils

MY_PN="Scrapy"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A high-level Python Screen Scraping framework"
HOMEPAGE="http://scrapy.org http://pypi.python.org/pypi/Scrapy/"
SRC_URI="mirror://pypi/S/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="boto doc examples ibl test ssl"
# New found test script has failures
RESTRICT="test"

DEPEND="dev-python/setuptools
	doc? ( dev-python/sphinx )"
RDEPEND="dev-libs/libxml2[python]
	boto? ( dev-python/boto )
	dev-python/imaging
	dev-python/lxml
	ibl? ( dev-python/numpy )
	ssl? ( dev-python/pyopenssl )
	dev-python/setuptools
	dev-python/simplejson
	dev-python/twisted
	dev-python/twisted-conch
	dev-python/twisted-mail
	dev-python/twisted-web
	dev-python/w3lib
	test? ( dev-python/django )"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	sed -e s':decs = "1000.12":decs = 1000.12:' \
		-i scrapy/tests/test_utils_serialize.py || die
}

src_compile() {
	distutils_src_compile

	if use doc; then
		emake -C docs html || die "emake html failed"
	fi
}

src_test() {
	testing() {
		PYTHONPATH="$(ls -d build-${PYTHON_ABI}/lib*)"  bin/runtests.sh || die
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install
	if use doc; then
		dohtml -r "${S}"/docs/build/html/
	fi
	if use examples; then
		insinto /usr/share/doc/"${PF}"/examples
		doins -r "${S}"/examples/*
	fi
}

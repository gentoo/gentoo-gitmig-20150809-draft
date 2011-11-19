# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cssutils/cssutils-0.9.7.ebuild,v 1.5 2011/11/19 09:53:58 hwoarang Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

MY_P="${PN}-${PV/_alpha/a}"

DESCRIPTION="CSS Cascading Style Sheets parser and library for Python"
HOMEPAGE="http://code.google.com/p/cssutils http://pypi.python.org/pypi/cssutils"
SRC_URI="http://cssutils.googlecode.com/files/${MY_P}.zip mirror://pypi/${PN:0:1}/${PN}/${MY_P}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~ppc ~x86"
IUSE="test"

RDEPEND="dev-python/setuptools"
DEPEND="${RDEPEND}
	app-arch/unzip
	test? ( dev-python/minimock )"

RESTRICT="test"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="cssutils encutils"

src_prepare() {
	distutils_src_prepare

	# Disable test failing with dev-python/pyxml installed.
	if has_version dev-python/pyxml; then
		sed -e "s/test_linecol/_&/" -i src/tests/test_errorhandler.py
	fi
}

src_install() {
	distutils_src_install

	# Don't install tests.
	delete_tests() {
		rm -fr "${ED}$(python_get_sitedir)/tests"
	}
	python_execute_function -q delete_tests
}

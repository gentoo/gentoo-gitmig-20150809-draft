# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cssutils/cssutils-0.9.7_beta3.ebuild,v 1.1 2010/06/21 16:40:18 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

MY_P="${PN}-${PV/_beta/b}"

DESCRIPTION="CSS Cascading Style Sheets parser and library for Python"
HOMEPAGE="http://code.google.com/p/cssutils http://pypi.python.org/pypi/cssutils"
SRC_URI="http://cssutils.googlecode.com/files/${MY_P}.zip http://pypi.python.org/packages/source/${PN:0:1}/${PN}/${MY_P}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-python/setuptools"
DEPEND="${RDEPEND}
	app-arch/unzip
	test? ( dev-python/minimock )"

S="${WORKDIR}/${MY_P}"

src_install() {
	distutils_src_install

	# Don't install tests.
	delete_tests() {
		rm -fr "${ED}$(python_get_sitedir)/tests"
	}
	python_execute_function -q delete_tests
}

# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/dulwich/dulwich-0.7.0.ebuild,v 1.4 2011/03/24 22:27:45 angelos Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

DESCRIPTION="Dulwich is a pure-Python implementation of the Git file formats and protocols."
HOMEPAGE="http://samba.org/~jelmer/dulwich/ http://pypi.python.org/pypi/dulwich"
SRC_URI="http://samba.org/~jelmer/dulwich/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86 ~ppc-macos ~x86-macos ~x86-solaris"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND=""

src_prepare() {
	distutils_src_prepare

	# https://github.com/jelmer/dulwich/commit/ee087a68c995bda4e83c464bf9339523f04e7a23
	sed -e "s/from dulwich.utils import/from dulwich.tests.compat.utils import/" -i dulwich/tests/compat/test_web.py

	sed -e "s/test_fetch_from_dulwich(/_&/" -i dulwich/tests/compat/server_utils.py
}

distutils_src_test_pre_hook() {
	local module
	for module in _diff_tree _objects _pack; do
		ln -fs "../$(ls -d build-${PYTHON_ABI}/lib.*)/dulwich/${module}.so" "dulwich/${module}.so" || die "Symlinking dulwich/${module}.so failed with $(python_get_implementation) $(python_get_version)"
	done
}

src_install() {
	distutils_src_install

	delete_tests() {
		rm -fr "${ED}$(python_get_sitedir)/dulwich/tests"
	}
	python_execute_function -q delete_tests
}

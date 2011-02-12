# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/dulwich/dulwich-0.7.0.ebuild,v 1.1 2011/02/12 00:33:22 arfrever Exp $

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
KEYWORDS="~amd64 ~x86 ~ppc-macos ~x86-solaris"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND=""

src_prepare() {
	distutils_src_prepare

	sed -e "s/from dulwich.utils import/from dulwich.tests.compat.utils import/" -i dulwich/tests/compat/test_web.py
	sed -e "/test_merge_entries =/,+1d" -i dulwich/tests/test_diff_tree.py
	sed -e "s/test_fetch_from_dulwich(/_&/" -i dulwich/tests/compat/server_utils.py
}

src_install() {
	distutils_src_install

	delete_tests() {
		rm -fr "${ED}$(python_get_sitedir)/dulwich/tests"
	}
	python_execute_function -q delete_tests
}

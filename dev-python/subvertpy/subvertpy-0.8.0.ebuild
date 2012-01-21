# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/subvertpy/subvertpy-0.8.0.ebuild,v 1.4 2012/01/21 15:50:50 klausman Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

DESCRIPTION="Alternative Python bindings for Subversion"
HOMEPAGE="http://samba.org/~jelmer/subvertpy/ http://pypi.python.org/pypi/subvertpy"
SRC_URI="http://samba.org/~jelmer/${PN}/${P}.tar.gz"

LICENSE="|| ( LGPL-2.1 LGPL-3 )"
SLOT="0"
KEYWORDS="alpha amd64 x86"
IUSE=""

DEPEND=">=dev-vcs/subversion-1.4"
RDEPEND="${DEPEND}"

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")

DOCS="NEWS AUTHORS"

distutils_src_test_pre_hook() {
	local module
	for module in _ra client repos wc; do
		ln -fs "../$(ls -d build-${PYTHON_ABI}/lib.*)/subvertpy/${module}.so" "subvertpy/${module}.so" || die "Symlinking subvertpy/${module}.so failed with $(python_get_implementation) $(python_get_version)"
	done
}

src_install() {
	distutils_src_install

	delete_tests() {
		rm -fr "${ED}$(python_get_sitedir)/subvertpy/tests"
	}
	python_execute_function -q delete_tests
}

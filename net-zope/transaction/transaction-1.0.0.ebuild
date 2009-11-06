# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/transaction/transaction-1.0.0.ebuild,v 1.2 2009/11/06 16:47:29 volkmar Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Transaction management for Python"
HOMEPAGE="http://pypi.python.org/pypi/transaction"
SRC_URI="http://pypi.python.org/packages/source/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~amd64 ~ppc"
IUSE="test"

RDEPEND="net-zope/zope-interface"
DEPEND="${RDEPEND}
	dev-python/setuptools
	test? ( dev-python/nose net-zope/zope-testing )"
RESTRICT_PYTHON_ABIS="3.*"

DOCS="CHANGES.txt README.txt"

src_test() {
	testing() {
		# Future versions of dev-python/nose will support Python 3.
		[[ "${PYTHON_ABI}" == 3.* ]] && return

		PYTHONPATH="build-${PYTHON_ABI}/lib" nosetests-${PYTHON_ABI}
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	# Don't install tests.
	rm -fr "${D}"usr/$(get_libdir)/python*/site-packages/transaction/tests
}

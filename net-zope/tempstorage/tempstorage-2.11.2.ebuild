# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/tempstorage/tempstorage-2.11.2.ebuild,v 1.1 2009/12/08 12:17:44 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="A RAM-based storage for ZODB"
HOMEPAGE="http://pypi.python.org/pypi/tempstorage"
SRC_URI="http://pypi.python.org/packages/source/${PN:0:1}/${PN}/${P}.zip"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND="net-zope/zodb"
DEPEND="${RDEPEND}
	app-arch/unzip
	dev-python/setuptools
	test? ( dev-python/nose )"
RESTRICT_PYTHON_ABIS="3.*"

DOCS="CHANGES.txt README.txt"

src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib" nosetests-${PYTHON_ABI}
	}
	python_execute_function testing
}

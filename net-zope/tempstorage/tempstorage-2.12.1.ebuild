# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/tempstorage/tempstorage-2.12.1.ebuild,v 1.1 2010/09/29 17:54:40 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

DESCRIPTION="A RAM-based storage for ZODB"
HOMEPAGE="http://pypi.python.org/pypi/tempstorage"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.zip"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE="test"

RDEPEND=">=net-zope/zodb-3.9.0"
DEPEND="${RDEPEND}
	app-arch/unzip
	dev-python/setuptools"

DOCS="CHANGES.txt README.txt"

src_install() {
	distutils_src_install

	delete_tests() {
		rm -fr "${ED}$(python_get_sitedir)/tempstorage/tests"
	}
	python_execute_function -q delete_tests
}

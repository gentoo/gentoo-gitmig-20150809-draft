# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zexceptions/zexceptions-2.13.0.ebuild,v 1.2 2010/10/30 18:17:03 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

MY_PN="zExceptions"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="zExceptions contains common exceptions used in Zope2."
HOMEPAGE="http://pypi.python.org/pypi/zExceptions"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.zip"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="net-zope/zope-interface
	net-zope/zope-publisher
	net-zope/zope-security"
DEPEND="app-arch/unzip
	dev-python/setuptools"

S="${WORKDIR}/${MY_P}"

DOCS="CHANGES.txt README.txt"
PYTHON_MODNAME="${MY_PN}"

src_install() {
	distutils_src_install

	# Don't install tests.
	delete_tests() {
		rm -fr "${ED}$(python_get_sitedir)/zExceptions/tests"
	}
	python_execute_function -q delete_tests
}

# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/accesscontrol/accesscontrol-2.13.4.ebuild,v 1.1 2011/01/15 00:02:03 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

MY_PN="AccessControl"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Security framework for Zope2."
HOMEPAGE="http://pypi.python.org/pypi/AccessControl"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.zip"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE="test"

RDEPEND="dev-python/restrictedpython
	net-zope/acquisition
	net-zope/extensionclass
	net-zope/persistence
	net-zope/record
	net-zope/zexceptions
	net-zope/zodb
	net-zope/zope-component
	net-zope/zope-configuration
	net-zope/zope-deferredimport
	net-zope/zope-interface
	net-zope/zope-publisher
	net-zope/zope-schema
	net-zope/zope-security"
DEPEND="${RDEPEND}
	app-arch/unzip
	dev-python/setuptools
	test? (
		net-zope/datetime
		net-zope/transaction
		net-zope/zope-testing
	)"

S="${WORKDIR}/${MY_P}"

DOCS="CHANGES.txt README.txt"
PYTHON_MODNAME="${MY_PN}"

src_prepare() {
	distutils_src_prepare

	# Disable broken tests.
	rm -f src/AccessControl/tests/testSecurityManager.py
	rm -f src/AccessControl/tests/testZopeSecurityPolicy.py
}

distutils_src_test_pre_hook() {
	local module
	for module in AccessControl; do
		ln -fs "../../$(ls -d build-${PYTHON_ABI}/lib.*)/${module}/c${module}.so" "src/${module}/c${module}.so" || die "Symlinking ${module}/c${module}.so failed with Python ${PYTHON_ABI}"
	done
}

src_install() {
	distutils_src_install
	python_clean_installation_image

	delete_tests() {
		rm -fr "${ED}$(python_get_sitedir)/AccessControl/tests"
	}
	python_execute_function -q delete_tests
}

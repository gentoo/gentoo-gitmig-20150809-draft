# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zope-testrunner/zope-testrunner-4.0.1.ebuild,v 1.1 2011/02/21 20:13:50 arfrever Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

MY_PN="${PN/-/.}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Zope testrunner script."
HOMEPAGE="http://pypi.python.org/pypi/zope.testrunner"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.zip"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE="examples"

RDEPEND="net-zope/zope-exceptions
	net-zope/zope-interface
	!<net-zope/zope-testing-3.10.0"
# net-zope/zope-fixers is required for building with Python 3.
DEPEND="${RDEPEND}
	app-arch/unzip
	dev-python/setuptools
	net-zope/zope-fixers"

S="${WORKDIR}/${MY_P}"

DOCS="CHANGES.txt README.txt"
PYTHON_MODNAME="${PN/-//}"

src_install() {
	distutils_src_install

	delete_examples() {
		rm -fr "${D}$(python_get_sitedir)/zope/testrunner/testrunner-ex"*
	}
	python_execute_function -q delete_examples

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r src/zope/testrunner/testrunner-ex{,-pp-lib,-pp-products} || die "Installation of examples failed"
	fi
}

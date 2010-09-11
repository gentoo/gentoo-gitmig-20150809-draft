# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zope-testing/zope-testing-3.10.0.ebuild,v 1.1 2010/09/11 21:36:03 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils

MY_PN="${PN/-/.}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Zope testing helpers"
HOMEPAGE="http://pypi.python.org/pypi/zope.testing"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="net-zope/zope-exceptions"
DEPEND="${RDEPEND}
	dev-python/setuptools"

S="${WORKDIR}/${MY_P}"

DOCS="CHANGES.txt README.txt"
PYTHON_MODNAME="${PN/-//}"

pkg_postinst() {
	distutils_pkg_postinst

	elog "zope-testrunner script has been moved to net-zope/zope-testrunner package."
}

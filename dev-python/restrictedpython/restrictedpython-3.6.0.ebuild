# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/restrictedpython/restrictedpython-3.6.0.ebuild,v 1.4 2010/12/26 15:38:00 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

MY_PN="RestrictedPython"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="RestrictedPython provides a restricted execution environment for Python, e.g. for running untrusted code."
HOMEPAGE="http://pypi.python.org/pypi/RestrictedPython"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.zip"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="app-arch/unzip
	dev-python/setuptools"
RDEPEND=""

S="${WORKDIR}/${MY_P}"

DOCS="CHANGES.txt src/RestrictedPython/README.txt"
PYTHON_MODNAME="${MY_PN}"

pkg_postinst() {
	python_mod_optimize -x /tests/ ${MY_PN}
}

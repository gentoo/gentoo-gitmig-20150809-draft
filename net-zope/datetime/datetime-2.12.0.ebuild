# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/datetime/datetime-2.12.0.ebuild,v 1.1 2009/12/08 12:29:27 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

MY_PN="DateTime"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="DateTime data type from Zope 2"
HOMEPAGE="http://pypi.python.org/pypi/DateTime"
SRC_URI="http://pypi.python.org/packages/source/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND="dev-python/pytz
	net-zope/zope-interface"
DEPEND="${RDEPEND}
	dev-python/setuptools
	test? ( dev-python/nose net-zope/zope-testing )"
RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="${MY_PN}"
DOCS="CHANGES.txt README.txt"

src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib" nosetests-${PYTHON_ABI}
	}
	python_execute_function testing
}

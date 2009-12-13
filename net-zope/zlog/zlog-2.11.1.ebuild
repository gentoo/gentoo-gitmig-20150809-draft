# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zlog/zlog-2.11.1.ebuild,v 1.1 2009/12/13 04:10:11 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

MY_PN="zLOG"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A general logging facility"
HOMEPAGE="http://pypi.python.org/pypi/zLOG"
SRC_URI="http://pypi.python.org/packages/source/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

DEPEND="dev-python/setuptools
	test? ( dev-python/nose )"
RDEPEND=""
RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="${MY_PN}"

src_test() {
	testing() {
		PYTHONPATH="$(ls -d build-${PYTHON_ABI}/lib)" nosetests-${PYTHON_ABI}
	}
	python_execute_function testing
}

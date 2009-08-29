# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zcbuildout/zcbuildout-1.4.1.ebuild,v 1.1 2009/08/29 20:22:34 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

MY_PN="zc.buildout"
MY_P=${MY_PN}-${PV}

DESCRIPTION="System for managing development buildouts"
HOMEPAGE="http://pypi.python.org/pypi/zc.buildout"
SRC_URI="http://pypi.python.org/packages/source/z/${MY_PN}/${MY_P}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/setuptools"
DEPEND="${RDEPEND}"

RESTRICT_PYTHON_ABIS="3*"

S="${WORKDIR}"/${MY_P}
DOCS="CHANGES.txt todo.txt"

src_install() {
	distutils_src_install

	# Remove README.txt installed in incorrect location.
	rm -f "${D}usr/README.txt"
}

# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyudev/pyudev-0.2.ebuild,v 1.1 2010/07/25 00:52:59 sbriesen Exp $

EAPI="2"

PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.[45] 3.*"

inherit distutils

DESCRIPTION="pyudev is a Python and PyQt4 binding for libudev"
HOMEPAGE="http://packages.python.org/pyudev/"
SRC_URI="http://pypi.python.org/packages/source/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="qt4"

RDEPEND="qt4? ( dev-python/PyQt4 )"
DEPEND="${RDEPEND}"

DOCS="CHANGES.rst"

src_prepare() {
	if ! use qt4; then
		sed -i -e "s:, 'qudev'::g" setup.py
	fi
	distutils_src_prepare
}

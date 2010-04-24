# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mock/mock-0.6.0.ebuild,v 1.3 2010/04/24 21:17:20 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="A Python Mocking and Patching Library for Testing"
HOMEPAGE="http://www.voidspace.org.uk/python/mock/ http://pypi.python.org/pypi/mock"
SRC_URI="http://www.voidspace.org.uk/downloads/${P}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND="app-arch/unzip"
RDEPEND=""
RESTRICT_PYTHON_ABIS="3.*"

DOCS="docs/*.txt"
PYTHON_MODNAME="mock.py"

src_install() {
	distutils_src_install

	if use doc; then
		dodoc mock.pdf
		dohtml -r html/*
	fi
}

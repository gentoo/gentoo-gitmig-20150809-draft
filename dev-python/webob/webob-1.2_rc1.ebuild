# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/webob/webob-1.2_rc1.ebuild,v 1.1 2012/05/15 15:59:11 xarthisius Exp $

EAPI=4

SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.5 3.1"
DISTUTILS_SRC_TEST=nosetests

inherit distutils versionator

MY_PN=WebOb
MY_PV=$(delete_version_separator 2)
MY_P=${MY_PN}-${MY_PV}

DESCRIPTION="WSGI request and response object"
HOMEPAGE="http://pythonpaste.org/webob/ http://pypi.python.org/pypi/WebOb"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="doc"

DEPEND="app-arch/unzip
	dev-python/setuptools
	doc? ( dev-python/sphinx )"
RDEPEND=""

S=${WORKDIR}/${MY_P}

src_compile() {
	distutils_src_compile

	if use doc; then
		"$(PYTHON -f)" setup.py build_sphinx || die
	fi
}

src_install() {
	distutils_src_install

	if use doc; then
		dohtml -r build/sphinx/html/
	fi
}

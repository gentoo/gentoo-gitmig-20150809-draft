# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/libcloud/libcloud-0.7.1.ebuild,v 1.1 2011/12/27 13:39:11 patrick Exp $

EAPI="3"

PYTHON_DEPEND="2:2.6 3"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.[45] *-jython"
DISTUTILS_SRC_TEST="setup.py"
PYTHON_TESTS_RESTRICTED_ABIS="3.*"
PYTHON_USE_WITH="ssl"

inherit distutils

DESCRIPTION="Unified Interface to the Cloud - python support libs"
HOMEPAGE="http://libcloud.apache.org/index.html"
SRC_URI="mirror://apache/${PN}/apache-${P}.tar.bz2"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

RDEPEND=""
DEPEND=""

S="${WORKDIR}/apache-${P}"

src_test() {
	cp test/secrets.py-dist test/secrets.py || die
	distutils_src_test
}

src_install() {
	distutils_src_install
	if use examples ; then
		docinto examples/
		dodoc "${S}"/example_*.py || die
	fi
}
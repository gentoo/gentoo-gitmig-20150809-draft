# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/autopep8/autopep8-0.5.2_p1.ebuild,v 1.1 2012/05/04 20:20:08 sping Exp $

EAPI=4

PYTHON_DEPEND="*:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.5-cpython"

inherit eutils distutils

MY_PV=${PV%%_p*}
DESCRIPTION="Automatically formats Python code to conform to the PEP 8 style guide"
HOMEPAGE="https://github.com/hhatto/autopep8 http://pypi.python.org/pypi/autopep8"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${PN}-${MY_PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/pep8
	dev-python/setuptools"
DEPEND="${RDEPEND}"

PYTHON_MODNAME="${PN}.py"

S=${WORKDIR}/${PN}-${MY_PV}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.5.2-issue-10.patch
}

src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" test/test_${PN}.py
	}
	python_execute_function testing
}

# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/myghty/myghty-1.1-r1.ebuild,v 1.1 2009/10/01 02:53:03 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils eutils

MY_PN="Myghty"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Template and view-controller framework derived from HTML::Mason."
HOMEPAGE="http://www.myghty.org"
SRC_URI="http://cheeseshop.python.org/packages/source/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"

RDEPEND=">=dev-python/routes-1.0
	dev-python/paste
	dev-python/pastedeploy
	dev-python/pastescript"
DEPEND="${RDEPEND}
	dev-python/setuptools"
RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	distutils_src_prepare

	epatch "${FILESDIR}/${P}-python-2.6.patch"
}

src_compile() {
	distutils_src_compile
	if use doc; then
		cd doc
		PYTHONPATH=./lib/ python genhtml.py || die "Generation of documentation failed"
	fi
}

src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" test/alltests.py
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install
	use doc && dohtml doc/html/*
}

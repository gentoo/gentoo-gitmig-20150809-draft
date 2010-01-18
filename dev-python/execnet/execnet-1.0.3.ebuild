# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/execnet/execnet-1.0.3.ebuild,v 1.1 2010/01/18 17:55:00 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Rapid multi-Python deployment"
HOMEPAGE="http://codespeak.net/execnet/ http://pypi.python.org/pypi/execnet"
SRC_URI="http://pypi.python.org/packages/source/e/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"

DEPEND="dev-python/setuptools
	doc? ( dev-python/sphinx )
	test? ( >=dev-python/py-1.1.1 )"
RDEPEND=""

src_compile() {
	distutils_src_compile
	if use doc; then
		pushd doc
		emake html || die "emake html failed"
		popd
	fi
}

src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib" py.test testing
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install
	if use doc; then
		dohtml -r doc/_build/html/* || die "dohtml failed"
	fi
}

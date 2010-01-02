# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/routes/routes-1.11.ebuild,v 1.3 2010/01/02 23:33:12 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

MY_PN="Routes"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A Python re-implementation of the Rails routes system for mapping URL's to Controllers/Actions."
HOMEPAGE="http://routes.groovie.org"
SRC_URI="http://pypi.python.org/packages/source/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="doc test"

DEPEND="dev-python/setuptools
	test? ( dev-python/coverage dev-python/nose )"
RDEPEND=""
RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${MY_P}"

src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}" nosetests-${PYTHON_ABI}
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	if use doc; then
		dohtml -r docs/_build/html/* || die "dohtml failed"
	fi
}

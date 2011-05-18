# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mpmath/mpmath-0.17.ebuild,v 1.2 2011/05/18 21:04:30 grozin Exp $

EAPI="3"
PYTHON_DEPEND="*:2.5"
SUPPORT_PYTHON_ABIS="1"
DISTUTILS_SRC_TEST="py.test"

inherit distutils eutils

MY_PN=${PN}-all
MY_P=${MY_PN}-${PV}
DESCRIPTION="Python library for arbitrary-precision floating-point arithmetic"
HOMEPAGE="http://code.google.com/p/mpmath/ http://pypi.python.org/pypi/mpmath"
SRC_URI="http://mpmath.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-linux ~ppc-macos"
IUSE="doc examples gmp matplotlib"

RDEPEND="gmp? ( dev-python/gmpy )
	matplotlib? ( dev-python/matplotlib )"
DEPEND="${RDEPEND}
	doc? ( dev-python/sphinx )"

DOCS="CHANGES"
S="${WORKDIR}/${MY_P}"

src_prepare() {
	distutils_src_prepare

	# don't install tests
	epatch "${FILESDIR}/${PN}.patch"

	# this fails with the current version of dev-python/py
	rm -f ${PN}/conftest.py

	# this test requires X
	rm -f ${PN}/tests/test_visualization.py
}

src_compile() {
	distutils_src_compile

	if use doc; then
		einfo "Generation of documentation"
		pushd doc > /dev/null
		PYTHONPATH="${S}/build-$(PYTHON -f --ABI)/lib" "$(PYTHON -f)" build.py || die "Generation of documentation failed"
		popd > /dev/null
	fi
}

src_install() {
	distutils_src_install

	if use doc; then
		dohtml -r doc/build/* || die "Installation of documentation failed"
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins demo/* || die "Installation of examples failed"
	fi

	rm_unneeded() {
		local path="${ED}$(python_get_sitedir)/${PN}/libmp/"
		if [[ "${PYTHON_ABI}" == 2.* ]]; then
			rm -f "${path}exec_py3.py"
		else if [[ "${PYTHON_ABI}" == 3.* ]]; then
			rm -f "${path}exec_py2.py"
		fi
		fi
	}

	python_execute_function rm_unneeded
}

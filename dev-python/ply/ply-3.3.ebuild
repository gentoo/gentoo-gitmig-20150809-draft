# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ply/ply-3.3.ebuild,v 1.4 2010/11/01 20:35:22 arfrever Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Python Lex-Yacc library"
HOMEPAGE="http://www.dabeaz.com/ply/ http://pypi.python.org/pypi/ply"
SRC_URI="http://www.dabeaz.com/ply/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86"
IUSE="examples"

DOCS="ANNOUNCE CHANGES"

src_prepare() {
	distutils_src_prepare
	sed -e "s/print repr(result)/print(repr(result))/" -i test/testyacc.py || die "sed failed"
}

src_test() {
	python_enable_pyc

	cd test

	testing() {
		local exit_status="0" test

		for test in testlex.py testyacc.py; do
			einfo "Running ${test}..."
			if ! "$(PYTHON)" testlex.py; then
				ewarn "${test} failed with $(python_get_implementation) $(python_get_version)"
				exit_status="1"
			fi
		done

		return "${exit_status}"
	}
	python_execute_function testing

	python_disable_pyc
}

src_install() {
	distutils_src_install

	dohtml doc/*

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r example || die "doins failed"
	fi
}

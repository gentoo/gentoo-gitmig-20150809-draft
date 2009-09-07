# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ply/ply-3.3.ebuild,v 1.1 2009/09/07 20:44:42 patrick Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Python Lex-Yacc library"
SRC_URI="http://www.dabeaz.com/ply/${P}.tar.gz"
HOMEPAGE="http://www.dabeaz.com/ply/"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86"
IUSE="examples"

src_prepare() {
	sed -e "s/print repr(result)/print(repr(result))/" -i test/testyacc.py || die "sed failed"
}

src_test() {
	python_enable_pyc

	cd test

	testing() {
		"$(PYTHON)" testlex.py || return 1
		"$(PYTHON)" testyacc.py || return 1
	}
	python_execute_function testing

	python_disable_pyc
}

src_install() {
	DOCS="ANNOUNCE CHANGES"
	distutils_src_install
	dohtml doc/*
	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r example
	fi
}

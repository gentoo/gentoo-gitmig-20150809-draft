# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyme/pyme-0.8.1.ebuild,v 1.2 2009/07/23 20:41:45 arfrever Exp $

EAPI="2"

inherit distutils eutils

DESCRIPTION="GPGME Interface for Python"
HOMEPAGE="http://pyme.sourceforge.net"
SRC_URI="mirror://sourceforge/pyme/${P}.tar.gz"

LICENSE="|| ( GPL-2 LGPL-2.1 )"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="doc examples"

RDEPEND=">=app-crypt/gpgme-0.9.0"
DEPEND="${RDEPEND}
	dev-lang/swig"

src_prepare() {
	distutils_src_prepare

	sed -i \
		-e 's:include/:include/gpgme/:' \
		-e 's/SWIGOPT :=.*/& -D_FILE_OFFSET_BITS=64/' \
		-e 's:$(PYTHON):/usr/bin/python:' \
		-e '/-rm doc\/\*\.html$/d' \
		Makefile || die "sed Makefile failed"
	sed -e 's/^\(define_macros = \).*/\1[("_FILE_OFFSET_BITS=64", None)]/' -i setup.py || die "sed setup.py failed"
}

src_compile() {
	PYTHON="/usr/bin/python"
	emake -j1 swig || die "emake swig failed"
	distutils_src_compile
}

src_install() {
	distutils_src_install
	use doc && dohtml -r doc/*

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins examples/*
	fi
}

src_test() {
	env PYTHONPATH=$(echo build/lib.*) \
		"${python}" examples/genkey.py || die "genkey test failed"
}

#src_test() {
#	tests() {
#		PYTHONPATH=$(echo build-${PYTHON_ABI}/lib.*) "${PYTHON}" examples/genkey.py || die "genkey test failed"
#	}
#	python_execute_function tests
#}

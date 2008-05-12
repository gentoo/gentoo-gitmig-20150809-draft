# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyme/pyme-0.6.0-r1.ebuild,v 1.3 2008/05/12 07:57:42 hawking Exp $

inherit distutils eutils

DESCRIPTION="GPGME Interface for Python"
HOMEPAGE="http://pyme.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc ppc"
IUSE="doc examples"

RDEPEND=">=app-crypt/gpgme-0.9.0"
DEPEND="${RDEPEND}
	dev-lang/swig"

src_unpack() {
	distutils_src_unpack

	sed -i \
		-e 's:include/:include/gpgme/:' \
		-e 's:$(PYTHON):/usr/bin/python:' \
		-e '/-rm doc\/\*\.html$/d' \
		Makefile || die "sed in Makefile failed"

	# Make it build with swig >=1.3.28
	# patch is originally written for 0.7.0 but works for this
	# version as well.
	epatch "${FILESDIR}/${PN}-swig-compatibility.patch"
}

src_compile() {
	emake -j1 swig || die "emake swig failed"
	distutils_src_compile

	if use doc; then
		emake docs || die "emake docs failed"
	fi
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
	PYTHONPATH="$(ls -d build/lib.*)" \
	${python} examples/genkey.py || die "genkey test failed"
}

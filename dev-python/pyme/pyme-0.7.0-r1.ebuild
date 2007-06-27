# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyme/pyme-0.7.0-r1.ebuild,v 1.2 2007/06/27 19:45:01 hawking Exp $

inherit distutils eutils

DESCRIPTION="GPGME Interface for Python"
HOMEPAGE="http://pyme.sourceforge.net"
SRC_URI="mirror://sourceforge/pyme/${P}.tar.gz"

LICENSE="|| ( GPL-2 LGPL-2.1 )"
SLOT="0"
KEYWORDS="~ia64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=">=app-crypt/gpgme-0.9.0"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i -e 's:include/:include/gpgme/:;s:$(PYTHON):/usr/bin/python:' Makefile
	# Make it build with swig >=1.3.28
	epatch "${FILESDIR}/${P}-swig-compatibility.patch"
}

src_compile() {
	PYTHON="/usr/bin/python"
	emake swig
	distutils_src_compile
}

src_install() {
	mydoc="examples/*"
	distutils_src_install
	dohtml -r doc/*
}

src_test() {
	env PYTHONPATH=$(echo build/lib.*) \
		"${python}" examples/genkey.py || die "genkey test failed"
}

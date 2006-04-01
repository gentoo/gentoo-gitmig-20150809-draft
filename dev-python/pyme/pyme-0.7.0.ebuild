# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyme/pyme-0.7.0.ebuild,v 1.2 2006/04/01 18:45:38 agriffis Exp $

inherit distutils

DESCRIPTION="GPGME Interface for Python"
SRC_URI="mirror://sourceforge/pyme/${P}.tar.gz"
HOMEPAGE="http://pyme.sourceforge.net"
DEPEND=">=app-crypt/gpgme-0.9.0"
SLOT="0"
KEYWORDS="~ia64 ~ppc ~sparc ~x86"
LICENSE="|| ( GPL-2 LGPL-2.1 )"
IUSE=""

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e 's:include/:include/gpgme/:;s:$(PYTHON):/usr/bin/python:' Makefile
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
	cd ${S}
	env PYTHONPATH=$(echo build/lib.*) \
	${python} examples/genkey.py || die "genkey test failed"
}


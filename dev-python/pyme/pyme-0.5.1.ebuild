# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyme/pyme-0.5.1.ebuild,v 1.8 2004/09/07 22:04:29 pythonhead Exp $

IUSE=""

DESCRIPTION="GPGME Interface for Python"
MY_P=${P/-/_}
SRC_URI="http://gopher.quux.org:70/devel/pyme/${MY_P}.tar.gz"
HOMEPAGE="http://gopher.quux.org:70/devel/pyme"

DEPEND="=app-crypt/gpgme-0.3.14-r1
	>=sys-apps/sed-4"

RDEPEND="=app-crypt/gpgme-0.3.14-r1
	dev-lang/swig"

SLOT="0"
KEYWORDS="~x86"
LICENSE="GPL-2"

inherit distutils

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e "s:gpgme-config:gpgme3-config:" \
		Makefile setup.py
}

src_test() {
	cd ${S}
	env PYTHONPATH=$(echo build/lib.*) \
	${python} examples/genkey.py || die "genkey test failed"
}

src_install() {
	mydoc="examples/*"
	distutils_src_install
	dohtml -r doc/*
}

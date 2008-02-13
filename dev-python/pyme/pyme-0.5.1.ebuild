# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyme/pyme-0.5.1.ebuild,v 1.16 2008/02/13 20:13:52 coldwind Exp $

inherit distutils

MY_P=${P/-/_}
DESCRIPTION="GPGME Interface for Python"
SRC_URI="http://quux.org/devel/pyme/${MY_P}.tar.gz"
HOMEPAGE="http://pyme.sf.net/"
SLOT="0"
KEYWORDS="x86 ~sparc ppc"
LICENSE="GPL-2"
IUSE=""
DEPEND="~app-crypt/gpgme-0.3.14
	>=sys-apps/sed-4"
RDEPEND="~app-crypt/gpgme-0.3.14
	dev-lang/swig"

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
	DOCS="examples/*"
	distutils_src_install
	dohtml -r doc/*
}

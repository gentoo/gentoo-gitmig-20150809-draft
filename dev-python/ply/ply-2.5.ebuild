# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ply/ply-2.5.ebuild,v 1.1 2009/07/01 06:29:47 patrick Exp $

EAPI="2"

inherit distutils

KEYWORDS="~amd64 ~ia64 ~ppc ~x86"

DESCRIPTION="Python Lex-Yacc library"
SRC_URI="http://www.dabeaz.com/ply/${P}.tar.gz"
HOMEPAGE="http://www.dabeaz.com/ply/"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE="examples"

src_prepare() {
	sed -i -e 's/md5,/hashlib,/' ply/yacc.py
	sed -i -e 's/md5.new/hashlib.md5/' ply/yacc.py
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

src_test() {
	cd test
	"${python}" rununit.py || die "test failed"
}

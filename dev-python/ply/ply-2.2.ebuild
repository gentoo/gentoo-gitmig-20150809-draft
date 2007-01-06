# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ply/ply-2.2.ebuild,v 1.1 2007/01/06 23:43:39 dev-zero Exp $

inherit distutils

KEYWORDS="~amd64 ~ia64 ~ppc ~x86"

DESCRIPTION="Python Lex-Yacc library"
SRC_URI="http://www.dabeaz.com/ply/${P}.tar.gz"
HOMEPAGE="http://www.dabeaz.com/ply/"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE="examples"

DEPEND=""
RDEPEND=""

src_install() {
	DOCS="ANNOUNCE CHANGES"
	distutils_src_install
	dohtml doc/*
	if use examples ; then
		insinto /usr/share/doc/${PF}
		doins -r example
	fi
}

src_test() {
	cd test
	python rununit.py || die "test failed"
}

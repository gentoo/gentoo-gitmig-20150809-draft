# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ply/ply-1.6.ebuild,v 1.2 2006/04/01 15:13:50 agriffis Exp $

inherit distutils

IUSE=""
DESCRIPTION="Python Lex-Yacc library"
SRC_URI="http://www.dabeaz.com/ply/${P}.tar.gz"
HOMEPAGE="http://www.dabeaz.com/ply/"
DEPEND="virtual/python"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86"

src_install() {
	distutils_src_install
	dohtml doc/*
	dodoc CHANGES TODO
	cp -r example ${D}/usr/share/doc/${PF}
}


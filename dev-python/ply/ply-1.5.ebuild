# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ply/ply-1.5.ebuild,v 1.4 2004/09/02 08:41:08 lv Exp $

inherit distutils

IUSE=""
DESCRIPTION="Python Lex-Yacc library"
SRC_URI="http://systems.cs.uchicago.edu/ply/${P}.tar.gz"
HOMEPAGE="http://systems.cs.uchicago.edu/ply/"
DEPEND="virtual/python"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"

src_install() {
	distutils_src_install
	dohtml doc/*
	dodoc CHANGES TODO
	cp -r example ${D}/usr/share/doc/${PF}
}


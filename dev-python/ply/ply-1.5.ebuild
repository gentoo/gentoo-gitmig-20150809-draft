# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ply/ply-1.5.ebuild,v 1.3 2004/07/09 00:30:56 mr_bones_ Exp $

inherit distutils

IUSE=""
DESCRIPTION="Python Lex-Yacc library"
SRC_URI="http://systems.cs.uchicago.edu/ply/${P}.tar.gz"
HOMEPAGE="http://systems.cs.uchicago.edu/ply/"
DEPEND="virtual/python"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc"

src_install() {
	distutils_src_install
	dohtml doc/*
	dodoc CHANGES TODO
	cp -r example ${D}/usr/share/doc/${PF}
}


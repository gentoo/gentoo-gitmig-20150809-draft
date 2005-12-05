# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyparsing/pyparsing-1.3.3.ebuild,v 1.1 2005/12/05 15:57:41 marienz Exp $

inherit distutils

DESCRIPTION="pyparsing is an easy-to-use Python module for text parsing"
SRC_URI="mirror://sourceforge/pyparsing/${P}.tar.gz"
HOMEPAGE="http://pyparsing.sourceforge.net/"
LICENSE="MIT"
SLOT="0"
DEPEND=">=dev-lang/python-2.3.2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

src_install() {
	dohtml HowToUsePyparsing.html
	dohtml -r htmldoc/*

	docinto examples
	dodoc examples/*

	distutils_src_install
}

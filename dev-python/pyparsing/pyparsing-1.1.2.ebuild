# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyparsing/pyparsing-1.1.2.ebuild,v 1.3 2004/09/02 08:48:19 lv Exp $

inherit distutils

DESCRIPTION="pyparsing is an easy-to-use Python module for text parsing"
SRC_URI="mirror://sourceforge/pyparsing/${P}.tar.gz"
HOMEPAGE="http://pyparsing.sourceforge.net/"
LICENSE="MIT"
SLOT="0"
DEPEND="dev-lang/python"
KEYWORDS="~x86 ~amd64"
IUSE=""

src_install() {
	dohtml HowToUsePyparsing.html
	dohtml -r htmldoc/*

	docinto examples
	dodoc examples/*

	distutils_src_install
}

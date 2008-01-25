# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyparsing/pyparsing-1.4.10.ebuild,v 1.1 2008/01/25 05:06:52 hawking Exp $

inherit distutils

DESCRIPTION="pyparsing is an easy-to-use Python module for text parsing"
SRC_URI="mirror://sourceforge/pyparsing/${P}.tar.gz"
HOMEPAGE="http://pyparsing.wikispaces.com/"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="doc examples"

src_install() {
	distutils_src_install

	dohtml HowToUsePyparsing.html || die
	dodoc CHANGES || die

	if use doc; then
		dohtml -r htmldoc/* || die
		insinto /usr/share/doc/${PF}
		doins docs/*.pdf || die
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples || die
	fi
}

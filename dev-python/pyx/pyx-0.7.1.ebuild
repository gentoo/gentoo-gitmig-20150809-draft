# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyx/pyx-0.7.1.ebuild,v 1.1 2004/12/20 14:10:17 kloeri Exp $

inherit distutils

MY_P=${P/pyx/PyX}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Python package for the generation of encapsulated PostScript figures"
SRC_URI="mirror://sourceforge/pyx/${MY_P}.tar.gz"
HOMEPAGE="http://pyx.sourceforge.net/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="doc"
DEPEND="virtual/python
	virtual/tetex"

DOCS="AUTHORS CHANGES INSTALL"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-0.7.1.patch
}

src_compile() {
	distutils_src_compile

	if use doc; then
		cd ${S}/faq
		make pdf
	fi
}

src_install() {
	distutils_src_install

	if use doc; then
		# The manual is not currently done because it needs mkhowto
		# that's not currently available on our python ebuild
		insinto /usr/share/doc/${P}/
		doins faq/pyxfaq.pdf
	fi
}

# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/biopython/biopython-1.40b.ebuild,v 1.1 2005/02/20 01:16:50 ribosome Exp $

inherit distutils

IUSE=""

DESCRIPTION="Biopython - Python modules for computational molecular biology"
SRC_URI="http://www.biopython.org/files/${P}.tar.gz"
HOMEPAGE="http://www.biopython.org"

DEPEND=">=dev-lang/python-2.2
		>=dev-python/egenix-mx-base-2.0.3
		>=dev-python/numeric-19.0
		>=dev-python/reportlab-1.11"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"

src_compile() {
	distutils_src_compile
}

src_install() {
	DOCS="Doc/* Doc/install/*.txt"
	distutils_src_install

	dohtml Doc/install/*.html
	cp -r Doc/examples/ ${D}/usr/share/doc/${PF}/
}

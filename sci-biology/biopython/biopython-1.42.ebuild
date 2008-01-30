# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/biopython/biopython-1.42.ebuild,v 1.7 2008/01/30 03:30:15 ribosome Exp $

inherit distutils

IUSE=""

DESCRIPTION="Biopython - Python modules for computational molecular biology"
SRC_URI="http://www.biopython.org/DIST/${P}.tar.gz"
HOMEPAGE="http://www.biopython.org"

DEPEND=">=dev-lang/python-2.2
		>=dev-python/egenix-mx-base-2.0.3
		>=dev-python/numeric-19.0
		>=dev-python/reportlab-1.11"

SLOT="0"
LICENSE="as-is"
KEYWORDS="alpha amd64 ppc sparc x86"

src_compile() {
	distutils_src_compile
}

src_install() {
	DOCS="Doc/*.txt Doc/*.tex Doc/install/*.txt"
	distutils_src_install

	dohtml Doc/install/*.html
	dohtml Doc/*.html
	cp -r Doc/examples/ Doc/*.pdf "${D}"/usr/share/doc/${PF}/
}

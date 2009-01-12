# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/fonttools/fonttools-2.2.ebuild,v 1.5 2009/01/12 15:15:32 pva Exp $

inherit distutils

DESCRIPTION="Library for manipulating TrueType, OpenType, AFM and Type1 fonts"
HOMEPAGE="http://fonttools.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ia64 ppc x86"
IUSE=""

DEPEND="virtual/python
	>=dev-python/numpy-1.0.2
	dev-python/pyxml"

DOCS="README.txt Doc/*.txt"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed '/data_files/{s:man/man1:share/man/man1:}' -i setup.py #247154
}

src_install() {
	distutils_src_install
	dohtml Doc/*.html
}

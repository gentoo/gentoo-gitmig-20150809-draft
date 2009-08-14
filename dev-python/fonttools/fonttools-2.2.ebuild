# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/fonttools/fonttools-2.2.ebuild,v 1.6 2009/08/14 15:35:10 arfrever Exp $

EAPI="2"

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

PYTHON_MODNAME="FontTools"

DOCS="README.txt Doc/*.txt"

src_prepare() {
	distutils_src_prepare
	sed '/data_files/{s:man/man1:share/man/man1:}' -i setup.py #247154
	epatch "${FILESDIR}/${P}-fix_syntax.patch"
}

src_install() {
	distutils_src_install
	dohtml Doc/*.html
}

# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/fonttools/fonttools-2.0_beta1.ebuild,v 1.10 2007/04/07 04:22:25 vapier Exp $

inherit distutils

MY_P=${P/_beta/b}
DESCRIPTION="Library for manipulating TrueType, OpenType, AFM and Type1 fonts"
HOMEPAGE="http://fonttools.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ia64 ppc x86"
IUSE=""

DEPEND="virtual/python
	dev-python/numeric
	dev-python/pyxml"

S=${WORKDIR}/${PN}

DOCS="README.txt Doc/*.txt"

src_install() {
	distutils_src_install
	dohtml Doc/*.html
}

# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/fonttools/fonttools-2.0_beta1-r1.ebuild,v 1.1 2007/07/18 23:07:06 hawking Exp $

inherit distutils eutils

MY_P=${P/_beta/b}
DESCRIPTION="Library for manipulating TrueType, OpenType, AFM and Type1 fonts"
HOMEPAGE="http://fonttools.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86"
IUSE=""

DEPEND="virtual/python
	>=dev-python/numpy-1.0.2
	dev-python/pyxml"

S=${WORKDIR}/${PN}

DOCS="README.txt Doc/*.txt"

src_unpack() {
	distutils_src_unpack

	epatch "${FILESDIR}/${P}-numpy.patch"
}

src_install() {
	distutils_src_install
	dohtml Doc/*.html
}

pkg_postinst() {
	ewarn "This version has been automatically adapted to use numpy.oldnumeric"
	ewarn "instead of the old numeric module. If this causes any unforeseen"
	ewarn "problems please file a bug on http://bugs.gentoo.org."
}

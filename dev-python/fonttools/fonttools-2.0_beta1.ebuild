# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/fonttools/fonttools-2.0_beta1.ebuild,v 1.6 2005/04/21 13:56:40 blubb Exp $

inherit distutils

MY_P=${P/_beta/b}
DESCRIPTION="Library for manipulating TrueType, OpenType, AFM and Type1 fonts."
HOMEPAGE="http://fonttools.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ppc ~amd64"
IUSE=""

DEPEND="virtual/python
	dev-python/numeric
	dev-python/pyxml"

S="${WORKDIR}/${PN}"

DOCS="README.txt Doc/*.txt"

src_install() {
	distutils_src_install

	insinto /usr/share/doc/${PF}/${DOCDESTTREE}
	doins Doc/*.html
}
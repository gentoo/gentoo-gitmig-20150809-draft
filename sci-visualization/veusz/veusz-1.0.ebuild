# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/veusz/veusz-1.0.ebuild,v 1.1 2007/11/02 01:48:18 cryos Exp $

inherit distutils

DESCRIPTION="Qt based scientific plotting package with good Postscript output."
HOMEPAGE="http://home.gna.org/veusz/"
SRC_URI="http://download.gna.org/${PN}/${P}.tar.gz"

IUSE="doc"
SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="GPL-2"

DEPEND="virtual/python
	dev-python/numarray
	dev-python/numpy
	dev-python/PyQt"
# To be added back in once fits is added to the tree
#    fits? ( >=dev-python/pyfits-0.9.8 )"

src_install() {
	distutils_src_install
	if use doc; then
		insinto /usr/share/doc/${PF}/examples
		doins examples/*
		docinto Documents
		dodoc Documents/Interface.txt
		dohtml -r Documents/{manual.xml,manimages}
		insinto /usr/share/doc/${PF}/Documents
		doins Documents/generate_manual.sh
	fi
}

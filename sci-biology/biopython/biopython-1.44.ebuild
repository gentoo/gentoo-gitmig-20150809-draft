# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/biopython/biopython-1.44.ebuild,v 1.1 2008/01/30 02:53:58 ribosome Exp $

inherit distutils eutils

DESCRIPTION="Biopython - Python modules for computational molecular biology"
LICENSE="as-is"
HOMEPAGE="http://www.biopython.org"
SRC_URI="http://www.biopython.org/DIST/${P}.tar.gz"

SLOT="0"
IUSE="kdtree"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"

DEPEND=">=dev-lang/python-2.2
		>=dev-python/egenix-mx-base-2.0.3
		>=dev-python/numeric-19.0
		>=dev-python/reportlab-1.11"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PN}-1.43-buildkdtree.patch"
	epatch "${FILESDIR}/${P}-sequtils-complement.patch"
	if use kdtree; then
		sed -i -e 's/USE_KDTREE = False/USE_KDTREE = True/' \
				setup.py || die "Could not apply patch for KDTree support."
	fi
}

src_compile() {
	distutils_src_compile
}

src_install() {
	DOCS="Doc/*.txt Doc/*.tex Doc/install/*.txt"
	distutils_src_install

	dohtml Doc/install/*.html || die "Failed to install HTML install docs."
	dohtml Doc/*.html || die "Failed to install HTML docs."
	cp -r Doc/examples/ Doc/*.pdf ${D}/usr/share/doc/${PF}/ || \
			die "Failed to install documentation."
}

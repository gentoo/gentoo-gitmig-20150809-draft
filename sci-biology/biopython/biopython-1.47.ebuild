# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/biopython/biopython-1.47.ebuild,v 1.1 2008/07/06 15:21:41 ribosome Exp $

EAPI=1

inherit distutils eutils

DESCRIPTION="Biopython - Python modules for computational molecular biology"
LICENSE="as-is"
HOMEPAGE="http://www.biopython.org"
SRC_URI="http://www.biopython.org/DIST/${P}.tar.gz"

SLOT="0"
IUSE="+kdtree"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"

DEPEND=">=dev-lang/python-2.2
		>=dev-python/egenix-mx-base-2.0.3
		>=dev-python/numeric-19.0
		>=dev-python/reportlab-1.11"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PN}-1.47-kdtree.patch"
	if use kdtree; then
		sed -i -e 's/USE_KDTREE = False/USE_KDTREE = True/' \
				setup.py || die "Could not apply patch for KDTree support."
	fi
}

src_compile() {
	distutils_src_compile
}

src_install() {
	DOCS="CONTRIB DEPRECATED NEWS README"
	distutils_src_install

	dodir "/usr/share/doc/${PF}"
	cp -r Doc/* "${D}/usr/share/doc/${PF}/" || \
			die "Failed to install documentation."
	dodir "/usr/share/${PN}"
	cp -r --preserve=mode Scripts Tests "${D}/usr/share/${PN}/" || \
			die "Failed to install shared files."
}

src_test() {
	cd "${S}/Tests"
	PYTHONPATH="${PYTHONPATH}:${S}" \
			python run_tests.py --no-gui || die "Tests failed."
}

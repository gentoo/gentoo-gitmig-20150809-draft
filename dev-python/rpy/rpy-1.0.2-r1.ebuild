# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/rpy/rpy-1.0.2-r1.ebuild,v 1.1 2008/05/07 08:33:02 bicatali Exp $

inherit distutils eutils

DESCRIPTION="Python interface to the R Programming Language"
HOMEPAGE="http://rpy.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1 MPL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~x86"
IUSE="doc examples"

RDEPEND=">=dev-lang/R-2.6.1
	dev-python/numpy"
DEPEND="${RDEPEND}
	doc? ( || ( virtual/tetex  dev-texlive/texlive-texinfo ) )"

src_unpack() {
	distutils_src_unpack
	epatch "${FILESDIR}"/${PN}-1.0_rc3-version-detect.patch
	epatch "${FILESDIR}"/${PN}-testfiles.patch
	epatch "${FILESDIR}"/${P}-rpymodule-R-2.7.patch
	# this module should exist only if R was built with USE=lapack
	if [[ -e /usr/$(get_libdir)/R/modules/lapack.so ]]; then
		sed -i \
			-e 's:Rlapack:lapack:g' \
			setup.py || die "sed in setup.py failed"
	fi
}

src_test() {
	cd tests
	PYTHONPATH=$(ls -d ../build/lib.*) \
		"${python}" testall.py || die "tests failed"
}

src_install() {
	distutils_src_install

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples || die
	fi

	if use doc; then
		cd doc
		emake html pdf || die "emake docs failed"
		dohtml rpy_html/* || die
		insinto /usr/share/doc/${PF}
		doins rpy.pdf || die
	fi
}

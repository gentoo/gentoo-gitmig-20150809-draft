# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/cfitsio/cfitsio-3.250-r1.ebuild,v 1.2 2011/03/16 12:33:49 grobian Exp $

EAPI=3
inherit autotools-utils

DESCRIPTION="C and Fortran library for manipulating FITS files"
HOMEPAGE="http://heasarc.gsfc.nasa.gov/docs/software/fitsio/fitsio.html"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris"
IUSE="doc fortran static-libs threads"

DEPEND="fortran? ( dev-lang/cfortran )"
RDEPEND=""

src_prepare() {
	# avoid internal cfortran
	if use fortran; then
		mv cfortran.h cfortran.h.disabled
		ln -s "${EPREFIX}"/usr/include/cfortran.h .
	fi
	autotools-utils_src_prepare
}

src_configure() {
	myeconfargs=(
		$(use_enable threads)
		$(use_enable fortran)
	)
	autotools-utils_src_configure
}

src_install () {
	insinto /usr/share/doc/${PF}/examples
	doins cookbook.c testprog.c speed.c smem.c
	use fortran && doins cookbook.f testf77.f && dodoc fitsio.doc
	dodoc changes.txt README cfitsio.doc
	if use doc; then
		insinto /usr/share/doc/${PF}
		doins quick.ps cfitsio.ps fpackguide.pdf
		use fortran && doins fitsio.ps
	fi
	autotools-utils_src_install
}

# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/cfitsio/cfitsio-3.270.ebuild,v 1.4 2011/06/28 10:43:39 grobian Exp $

EAPI=3
inherit autotools-utils

DESCRIPTION="C and Fortran library for manipulating FITS files"
HOMEPAGE="http://heasarc.gsfc.nasa.gov/docs/software/fitsio/fitsio.html"
SRC_URI="http://dev.gentoo.org/~bicatali/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86 ~x64-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris"
IUSE="doc fortran static-libs threads"

RDEPEND="sys-libs/zlib"
DEPEND="${RDEPEND}
	fortran? ( dev-lang/cfortran )"

src_prepare() {
	# avoid internal cfortran
	if use fortran; then
		mv cfortran.h cfortran.h.disabled
		ln -s "${EPREFIX}"/usr/include/cfortran.h .
	fi
	autotools-utils_src_prepare
	# fix stupdity in zlib check macro
	sed -i -e '/^ZLIB_HOME=\/usr\/local/d' configure || die
}

src_configure() {
	myeconfargs=(
		$(use_enable threads)
		$(use_enable fortran)
		"--with-zlib=${EPREFIX}/usr"
	)
	autotools-utils_src_configure
}

src_install () {
	insinto /usr/share/doc/${PF}/examples
	doins cookbook.c testprog.c speed.c smem.c
	use fortran && doins cookbook.f testf77.f && dodoc fitsio.doc
	dodoc changes.txt README README.repack cfitsio.doc
	use doc && dodoc quick.pdf cfitsio.pdf fpackguide.pdf
	use doc && use fortran && doins fitsio.pdf
	autotools-utils_src_install
}

# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/cfitsio/cfitsio-3.060.ebuild,v 1.1 2007/09/10 20:27:58 bicatali Exp $

inherit eutils fortran autotools

DESCRIPTION="C and Fortran library for manipulating FITS files"
HOMEPAGE="http://heasarc.gsfc.nasa.gov/docs/software/fitsio/fitsio.html"
SRC_URI="ftp://heasarc.gsfc.nasa.gov/software/fitsio/c/${PN}${PV//.}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE="doc fortran"

DEPEND="fortran? ( dev-lang/cfortran )"

S=${WORKDIR}/${PN}

pkg_setup() {
	if use fortran; then
		FORTRAN="gfortran g77 ifc"
		fortran_pkg_setup
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	# sed to avoid internal cfortran
	if use fortran; then
		sed -i \
			-e 's:"cfortran.h":<cfortran.h>:' \
			f77_wrap.h || die "sed fortran failed"
	fi
	epatch "${FILESDIR}"/${P}-autotools.patch
	eautoreconf
}

src_compile() {
	econf $(use_enable fortran) || die "econf failed"
	emake || die "emake failed"
}

src_test() {
	einfo "Testing cfitsio"
	./testprog > testprog.lis
	diff testprog.lis testprog.out || die "test failed"
	cmp testprog.fit testprog.std  || die "failed"
	if use fortran; then
		einfo "Testing cfitsio fortran wrappers"
		./testf77 > testf77.lis
		diff testf77.lis testf77.out || die "test failed"
		cmp testf77.fit testf77.std  || die "failed"
	fi
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc changes.txt README License.txt cfitsio.doc || die "dodoc failed"
	insinto /usr/share/doc/${PF}
	doins cookbook.c || die "install cookbook failed"
	use doc && dodoc cfitsio.ps quick.ps
	if use fortran; then
		doins cookbook.f || die "install cookbook failed"
		dodoc fitsio.doc
		use doc && dodoc fitsio.ps
	fi
}

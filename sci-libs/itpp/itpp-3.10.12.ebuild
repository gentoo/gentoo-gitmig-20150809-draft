# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/itpp/itpp-3.10.12.ebuild,v 1.3 2007/09/01 22:58:20 angelos Exp $

inherit fortran

DESCRIPTION="IT++ is a C++ library of mathematical, signal processing, speech processing, and communications classes and functions"
LICENSE="GPL-2"
HOMEPAGE="http://itpp.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 ~sparc ~x86"
IUSE="blas cblas debug doc fftw lapack"

DEPEND="fftw? ( || ( >=sci-libs/fftw-3.0.0
					>=sci-libs/acml-2.5.3 ) )
		blas? ( virtual/blas
				cblas? ( || ( >=sci-libs/gsl-1.4
							>=sci-libs/acml-2.5.3
							>=sci-libs/mkl-8.1
							>=sci-libs/blas-atlas-3.6.0
							sci-libs/cblas-reference ) )
				lapack? ( virtual/lapack ) )
		doc? ( app-doc/doxygen
				virtual/tetex )"

pkg_setup() {
	# lapack/cblas can only be used in conjunction with blas
	if use cblas && ! use blas; then
		die "USE=cblas requires USE=blas to be set"
	fi
	if use lapack && ! use blas; then
		die "USE=lapack requires USE=blas to be set"
	fi
}

src_compile() {
	local myconf

	if use blas; then
		myconf="--with-blas=-lblas"
	else
		myconf="--without-blas"
	fi
	econf $(use_enable doc html-doc) \
		$(use_enable debug) \
		$(use_with cblas) \
		$(use_with lapack) \
		$(use_with fftw fft) \
		"$myconf" \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR=${D} || die "make install failed"
	dodoc AUTHORS ChangeLog* INSTALL NEWS* README || \
		die "failed to install docs"
}

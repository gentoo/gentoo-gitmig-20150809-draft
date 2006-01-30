# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/itpp/itpp-3.9.1.ebuild,v 1.1 2006/01/30 17:15:45 markusle Exp $

inherit fortran

DESCRIPTION="IT++ is a C++ library of mathematical, signal processing, speech processing, and communications classes and functions"
LICENSE="GPL-2"
HOMEPAGE="http://itpp.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86"
IUSE="blas debug doc fftw lapack"

DEPEND="fftw? ( >=sci-libs/fftw-3.0.0 )
		blas? ( sci-libs/blas-atlas )
		lapack? ( virtual/lapack )
		doc? ( app-doc/doxygen
				app-text/tetex )"

src_compile() {
	econf $(use_enable doc html-doc) \
		$(use_enable debug) \
		$(use_with fftw) \
		$(use_with blas ) \
		$(use_with blas cblas) \
		$(use_with lapack) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR=${D} || die "make install failed"
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO || \
		die "failed to install docs"
}

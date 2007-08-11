# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/itpp/itpp-3.99.3.1.ebuild,v 1.1 2007/08/11 14:02:55 markusle Exp $

inherit fortran flag-o-matic

DESCRIPTION="IT++ is a C++ library of mathematical, signal processing, speech processing, and communications classes and functions"
LICENSE="GPL-2"
HOMEPAGE="http://itpp.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="blas debug doc fftw lapack minimal"

DEPEND="!minimal? ( fftw? ( || ( >=sci-libs/fftw-3.0.0
								>=sci-libs/acml-2.5.3 ) ) )
		blas? ( virtual/blas
				lapack? ( virtual/lapack ) )
		doc? ( app-doc/doxygen
				virtual/tetex )"

pkg_setup() {
	# lapack can only be used in conjunction with blas
	if use lapack && ! use blas; then
		die "USE=lapack requires USE=blas to be set"
	fi
}

src_compile() {
	# turn off performance critical debug code in development
	# versions
	append-flags -DNDEBUG

	local myconf
	if use blas; then
		myconf="--with-blas=-lblas"
	else
		myconf="--without-blas"
	fi

	if use minimal; then
		myconf="${myconf} --disable-comm --disable-fixed --disable-optim --disable-protocol --disable-signal --disable-srccode"
	fi

	econf $(use_enable doc html-doc) \
		$(use_enable debug) \
		$(use_with lapack) \
		$(use_with fftw fft) \
		"${myconf}" \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR=${D} || die "make install failed"
	dodoc AUTHORS ChangeLog ChangeLog-2006 ChangeLog-2005 INSTALL \
		NEWS NEWS-3.10 README TODO || die "failed to install docs"
}

# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/itpp/itpp-4.0.7-r1.ebuild,v 1.1 2010/08/10 18:24:27 bicatali Exp $

EAPI=3
inherit flag-o-matic

DESCRIPTION="C++ library of mathematical, signal processing and communication classes and functions"
LICENSE="GPL-2"
HOMEPAGE="http://itpp.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="blas debug doc fftw lapack minimal static-libs"

RDEPEND="!minimal? ( fftw? ( >=sci-libs/fftw-3 ) )
	blas? ( virtual/blas lapack? ( virtual/lapack ) )"
DEPEND="${RDEPEND}
	blas? ( dev-util/pkgconfig )
	lapack? ( dev-util/pkgconfig )
	doc? ( app-doc/doxygen virtual/latex-base )"

src_prepare() {
	epatch "${FILESDIR}"/${P}-fastica-fix-endless-loop.patch
}

src_configure() {
	# turn off performance critical debug code
	use debug || append-flags -DNDEBUG
	local blasconf="no"
	use blas && blasconf="$(pkg-config --libs blas)"
	local lapackconf="no"
	use lapack && lapackconf="$(pkg-config --libs blas lapack)"
	econf \
		--docdir="${EPREFIX}/usr/share/doc/${PF}" \
		--enable-shared \
		$(use_enable doc html-doc) \
		$(use_enable debug) \
		$(use_enable !minimal comm) \
		$(use_enable !minimal fixed) \
		$(use_enable !minimal optim) \
		$(use_enable !minimal protocol) \
		$(use_enable !minimal signal) \
		$(use_enable !minimal srccode) \
		$(use_enable static-libs static) \
		$(use_with fftw fft) \
		--with-blas="${blasconf}" \
		--with-lapack="${lapackconf}"
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"
	dodoc AUTHORS ChangeLog ChangeLog-2007 ChangeLog-2006 \
		ChangeLog-2005 INSTALL NEWS NEWS-3.10 NEWS-3.99 README TODO
}

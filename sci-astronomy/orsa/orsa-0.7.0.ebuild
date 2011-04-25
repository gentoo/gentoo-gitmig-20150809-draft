# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/orsa/orsa-0.7.0.ebuild,v 1.6 2011/04/25 15:04:13 armin76 Exp $

EAPI=1

inherit flag-o-matic multilib

DESCRIPTION="Celestial orbit reconstruction, simulation and analysis"
HOMEPAGE="http://orsa.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="opengl mpi ginac cln gsl fftw xinerama threads static"

DEPEND=">=sys-libs/readline-4.2
	opengl? ( virtual/opengl )
	fftw?  ( =sci-libs/fftw-2.1* )
	gsl?   ( >=sci-libs/gsl-1.5 )
	mpi?   ( sys-cluster/openmpi )
	ginac? ( >=sci-mathematics/ginac-1.2.0 )
	cln?   ( >=sci-libs/cln-1.1.6 )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc41.patch
	epatch "${FILESDIR}"/${PN}-0.6.1-as-needed.patch
	epatch "${FILESDIR}"/${P}-gcc4.3.patch
}

src_compile() {
	local myconf="--with-qt-dir=/no/such/file"
	use mpi || export MPICXX="g++"
	use ginac || myconf="--with-ginac-prefix=/no/such/file"
	use gsl || myconf="${myconf} --with-gsl-prefix=/no/such/file"
	use cln || myconf="${myconf} --with-cln-prefix=/no/such/file"
	if use fftw; then
		sed -i -e 's/have_fftw=yes/have_fftw=no/' configure \
		|| die "sed to fix fftw failed"
	fi
	if use mpi; then
		sed -e "s|\(orsa_LDADD = .*\)|\1 /usr/$(get_libdir)/libmpi.la /usr/$(get_libdir)/libmpi_cxx.la|" \
			-i src/orsa/Makefile.in || die "sed to fix MPI failed"
	fi

	econf \
		${myconf} \
		$(use_with mpi) \
		$(use_with opengl gl) \
		$(use_with threads) \
		$(use_with xinerama) \
		$(use_enable static) \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS COPYRIGHT DEVELOPERS TODO THANKS
	insinto /usr/share/${P}/test
	doins src/test/*.{cc,h,fft,ggo} || die "Failed to install tests"
}

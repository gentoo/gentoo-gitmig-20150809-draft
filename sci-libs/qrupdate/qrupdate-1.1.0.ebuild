# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/qrupdate/qrupdate-1.1.0.ebuild,v 1.12 2011/12/20 17:21:27 bicatali Exp $

EAPI="2"

inherit eutils fortran-2 toolchain-funcs versionator

DESCRIPTION="A library for fast updating of QR and Cholesky decompositions"
HOMEPAGE="http://sourceforge.net/projects/qrupdate"
SRC_URI="mirror://sourceforge/qrupdate/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="alpha amd64 hppa ppc ppc64 sparc x86"
IUSE=""

RDEPEND="
	virtual/fortran
	virtual/blas
		virtual/lapack"
DEPEND="${RDEPEND}
		dev-util/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.0.1-makefile.patch

	local BLAS_LIBS="$(pkg-config --libs blas)"
	local LAPACK_LIBS="$(pkg-config --libs lapack)"

	sed -i Makeconf \
		-e "s:gfortran:$(tc-getFC):g" \
		-e "s:FFLAGS=.*:FFLAGS=${FFLAGS}:" \
		-e "s:BLAS=.*:BLAS=${BLAS_LIBS}:" \
		-e "s:LAPACK=.*:LAPACK=${LAPACK_LIBS}:" \
		|| die "Failed to set up Makeconf"
}

src_compile() {
	emake solib || die "emake failed"
}

src_install() {
	newlib.so libqrupdate.so libqrupdate.so.1 \
		|| die "Failed to install libqrupdate.so.1"
	dosym libqrupdate.so.1 /usr/$(get_libdir)/libqrupdate.so
	dodoc README ChangeLog || die "dodoc failed"
}

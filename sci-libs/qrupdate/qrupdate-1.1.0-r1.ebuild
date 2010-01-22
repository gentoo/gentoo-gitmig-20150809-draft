# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/qrupdate/qrupdate-1.1.0-r1.ebuild,v 1.2 2010/01/22 14:09:12 markusle Exp $

EAPI="2"

inherit eutils fortran multilib

DESCRIPTION="A library for fast updating of QR and Cholesky decompositions"
HOMEPAGE="http://sourceforge.net/projects/qrupdate"
SRC_URI="mirror://sourceforge/qrupdate/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86 ~ppc-macos"
IUSE=""

RDEPEND="virtual/blas
		virtual/lapack"
DEPEND="${RDEPEND}
		dev-util/pkgconfig"

FORTRAN="gfortran ifc g77"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.0.1-makefile.patch
	# both patches below are already in upstream SVN
	epatch "${FILESDIR}"/${PN}-1.1.0-darwin-dylib.patch
	epatch "${FILESDIR}"/${PN}-1.1.0-destdir.patch

	local BLAS_LIBS="$(pkg-config --libs blas)"
	local LAPACK_LIBS="$(pkg-config --libs lapack)"

	sed -i Makeconf \
		-e "s:gfortran:${FORTRANC}:g" \
		-e "s:FFLAGS=.*:FFLAGS=${FFLAGS}:" \
		-e "s:BLAS=.*:BLAS=${BLAS_LIBS}:" \
		-e "s:LAPACK=.*:LAPACK=${LAPACK_LIBS}:" \
		-e "/^LIBDIR=/a\PREFIX=${EPREFIX}/usr" \
		-e "s:LIBDIR=lib:LIBDIR=$(get_libdir):" \
		|| die "Failed to set up Makeconf"
}

src_compile() {
	emake solib || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install-shlib || die "emake install failed"

	dodoc README ChangeLog || die "dodoc failed"
}

# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/qrupdate/qrupdate-1.0.1.ebuild,v 1.6 2009/12/26 15:43:45 armin76 Exp $

EAPI="2"

inherit eutils fortran

DESCRIPTION="A library for fast updating of QR and Cholesky decompositions"
HOMEPAGE="http://sourceforge.net/projects/qrupdate"
SRC_URI="mirror://sourceforge/qrupdate/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="virtual/blas
		virtual/lapack"
DEPEND="${RDEPEND}
		dev-util/pkgconfig"

FORTRAN="gfortran ifc g77"

src_prepare() {
	epatch "${FILESDIR}"/${P}-makefile.patch

	local BLAS_LIBS="$(pkg-config --libs blas)"
	local LAPACK_LIBS="$(pkg-config --libs lapack)"

	sed -i Makeconf \
		-e "s:gfortran:${FORTRANC}:g" \
		-e "s:FFLAGS=.*:FFLAGS=${FFLAGS}:" \
		-e "s:BLAS=.*:BLAS=${BLAS_LIBS}:" \
		-e "s:LAPACK=.*:LAPACK=${LAPACK_LIBS}:" \
		|| die "Failed to set up Makeconf"
}

src_compile() {
	emake solib || die "emake failed"
}

src_install() {
	dolib.so libqrupdate.so \
		|| die "Failed to install libqrupdate.so"

	dodoc README ChangeLog || die "dodoc failed"
}

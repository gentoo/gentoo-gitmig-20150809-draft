# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/qrupdate/qrupdate-1.1.1.ebuild,v 1.2 2011/06/21 09:52:02 jlec Exp $

EAPI="2"

inherit eutils fortran-2 multilib toolchain-funcs

DESCRIPTION="A library for fast updating of QR and Cholesky decompositions"
HOMEPAGE="http://sourceforge.net/projects/qrupdate"
SRC_URI="mirror://sourceforge/qrupdate/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86 ~ppc-macos"
IUSE="static-libs"

RDEPEND="virtual/lapack"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${P}-Makefiles.patch
	sed -i Makeconf \
		-e "s:gfortran:$(tc-getFC):g" \
		-e "s:FFLAGS=.*:FFLAGS=${FFLAGS}:" \
		-e "s:BLAS=.*:BLAS=$(pkg-config --libs blas):" \
		-e "s:LAPACK=.*:LAPACK=$(pkg-config --libs lapack):" \
		-e "/^LIBDIR=/a\PREFIX=${EPREFIX}/usr" \
		-e "s:LIBDIR=lib:LIBDIR=$(get_libdir):" \
		|| die "Failed to set up Makeconf"
}

src_compile() {
	emake solib || die "emake shared lib failed"
	if use static-libs; then
		emake lib || die "emake static lib failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install-shlib || die "emake shared lib install failed"
	if use static-libs; then
		emake DESTDIR="${D}" install-staticlib || die "emake static lib install failed"
	fi
	dodoc README ChangeLog
}

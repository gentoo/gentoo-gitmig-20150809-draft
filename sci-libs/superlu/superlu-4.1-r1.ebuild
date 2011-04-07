# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/superlu/superlu-4.1-r1.ebuild,v 1.4 2011/04/07 17:43:27 grobian Exp $

EAPI="2"

inherit autotools eutils toolchain-funcs multilib

MY_PN=SuperLU

DESCRIPTION="Sparse LU factorization library"
HOMEPAGE="http://crd.lbl.gov/~xiaoye/SuperLU/"
SRC_URI="${HOMEPAGE}/${PN}_${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc examples static-libs test"

RDEPEND="virtual/blas"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	test? ( app-shells/tcsh )"

S="${WORKDIR}/${MY_PN}_${PV}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-autotools.patch
	eautoreconf
}

src_configure() {
	econf \
		--with-blas="$(pkg-config --libs blas)" \
		$(use_enable static-libs static)
}

src_test() {
	cd TESTING
	emake -j1 \
		CC="$(tc-getCC)" \
		FORTRAN="$(tc-getFC)" \
		LOADER="$(tc-getCC)" \
		CFLAGS="${CFLAGS}" \
		FFLAGS="${FFLAGS}" \
		LOADOPTS="${LDFLAGS}" \
		BLASLIB="$(pkg-config --libs blas)" \
		SUPERLULIB="${S}/SRC/.libs/libsuperlu$(get_libname)" \
		LD_LIBRARY_PATH="${S}/SRC/.libs" \
		DYLD_LIBRARY_PATH="${S}/SRC/.libs" \
		|| die "emake matrix generation failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README

	if use doc; then
		dodoc DOC/ug.pdf || die
		dohtml DOC/html/* || die
	fi
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r EXAMPLE FORTRAN || die
	fi
}

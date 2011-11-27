# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/superlu/superlu-4.3.ebuild,v 1.1 2011/11/27 04:14:47 bicatali Exp $

EAPI=4

inherit autotools eutils fortran-2 toolchain-funcs multilib

MY_PN=SuperLU

DESCRIPTION="Sparse LU factorization library"
HOMEPAGE="http://crd.lbl.gov/~xiaoye/SuperLU/"
SRC_URI="${HOMEPAGE}/${PN}_${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc examples static-libs test"

RDEPEND="virtual/fortran
	virtual/blas"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	test? ( app-shells/tcsh )"

S="${WORKDIR}/${MY_PN}_${PV}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-4.2-autotools.patch
	sed -i -e "s/4.2/${PV}/" configure.ac || die
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
		DYLD_LIBRARY_PATH="${S}/SRC/.libs"
}

src_install() {
	default
	use doc && dodoc DOC/ug.pdf && dohtml DOC/html/*
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r EXAMPLE FORTRAN
	fi
}

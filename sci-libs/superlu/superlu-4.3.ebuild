# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/superlu/superlu-4.3.ebuild,v 1.4 2012/06/24 08:28:25 jlec Exp $

EAPI=4

AUTOTOOLS_AUTORECONF=true

inherit autotools-utils fortran-2 toolchain-funcs multilib

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
	virtual/pkgconfig
	test? ( app-shells/tcsh )"

S="${WORKDIR}/${MY_PN}_${PV}"

AUTOTOOLS_IN_SOURCE_BUILD=1
PATCHES=( "${FILESDIR}"/${P}-autotools.patch )

pkg_setup() {
	unset VERBOSE
}

src_configure() {
	local myeconfargs=( --with-blas="$(pkg-config --libs blas)" )
	autotools-utils_src_configure
}

src_test() {
	cd "${AUTOTOOLS_BUILD_DIR}"/TESTING
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
	autotools-utils_src_install
	use doc && dodoc DOC/ug.pdf && dohtml DOC/html/*
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r EXAMPLE FORTRAN
	fi
}

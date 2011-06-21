# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/superlu/superlu-4.0-r2.ebuild,v 1.3 2011/06/21 14:45:38 jlec Exp $

EAPI="2"

inherit autotools eutils fortran-2 toolchain-funcs

MY_PN=SuperLU

DESCRIPTION="Sparse LU factorization library"
HOMEPAGE="http://crd.lbl.gov/~xiaoye/SuperLU/"
SRC_URI="${HOMEPAGE}/${PN}_${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc examples static-libs test"

RDEPEND="
	virtual/fortran
	virtual/blas"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	test? ( app-shells/tcsh )"

S="${WORKDIR}/${MY_PN}_${PV}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-autotools.patch
	epatch "${FILESDIR}"/${PN}-examples.patch
	epatch "${FILESDIR}"/${PV}-test.patch
	eautoreconf
}

src_configure() {
	econf \
		--with-blas="$(pkg-config --libs blas)" \
		$(use_enable static-libs static)
}

src_test() {
	cd TESTING/MATGEN
	emake \
		FORTRAN="$(tc-getFC)" \
		LOADER="$(tc-getCC)" \
		CFLAGS="${CFLAGS}" \
		FFLAGS="${FFLAGS}" \
		LOADOPTS="${LDFLAGS}" \
		BLASLIB="$(pkg-config --libs blas)" \
		CC="$(tc-getCC)" \
		|| die "emake matrix generation failed"
	cd ..
	emake \
		CC="$(tc-getCC)" \
		FORTRAN="$(tc-getFC)" \
		LOADER="$(tc-getCC)" \
		CFLAGS="${CFLAGS}" \
		FFLAGS="${FFLAGS}" \
		LOADOPTS="${LDFLAGS}" \
		SUPERLULIB="../SRC/.libs/libsuperlu.so" \
		BLASLIB="$(pkg-config --libs blas)" \
		LD_LIBRARY_PATH="../SRC/.libs" \
		|| die "emake test failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	insinto /usr/include/${PN}
	doins SRC/*.h || die

	dodoc README
	use doc && newdoc INSTALL/ug.ps userguide.ps
	if use examples; then
		insinto /usr/share/doc/${PF}
		newins -r EXAMPLE examples
	fi
}

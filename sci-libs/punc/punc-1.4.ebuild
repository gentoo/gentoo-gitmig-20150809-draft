# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/punc/punc-1.4.ebuild,v 1.1 2010/10/31 13:30:08 jlec Exp $

EAPI="3"

inherit autotools multilib

DESCRIPTION="Portable Understructure for Numerical Computing"
HOMEPAGE="http://fetk.org/codes/punc/index.html"
SRC_URI="http://www.fetk.org/codes/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug mpi static-libs"

DEPEND="
	dev-libs/maloc[mpi=]
	dev-libs/libf2c
	sci-libs/amd
	sci-libs/cgcode
	sci-libs/arpack[mpi=]
	sci-libs/superlu
	sci-libs/umfpack
	virtual/blas
	mpi? ( virtual/mpi )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

src_prepare() {
	rm -rf src/{amd,blas,lapack,arpack,superlu,umfpack}
	epatch \
		"${FILESDIR}"/${PV}-linking.patch

	cp tools/tests/pmg/*.f src/pmg/ -f
	cp tools/tests/pmg/*.c src/pmg/ -f
	cp src/pmg/vpmg.h src/vf2c/punc/vpmg.h

	eautoreconf
}

src_configure() {
	export FETK_INCLUDE="${EPREFIX}/usr/include"
	export FETK_LIBRARY="${EPREFIX}/usr/$(get_libdir)"
	export FETK_LAPACK_LIBRARY="$(pkg-config --libs lapack)"
	export FETK_BLAS_LIBRARY="${FETK_LIBRARY}"
	export FETK_SUPERLU_LIBRARY="-lsuperlu"
	export FETK_ARPACK_LIBRARY="${EPREFIX}/usr/$(get_libdir)"
	export FETK_UMFPACK_LIBRARY="${EPREFIX}/usr/$(get_libdir)"
	export FETK_CGCODE_LIBRARY="${EPREFIX}/usr/$(get_libdir)"
	export FETK_AMD_LIBRARY="${EPREFIX}/usr/$(get_libdir)"

	econf \
		$(use_enable static-libs static) \
		$(use_enable debug vdebug) \
		--enable-shared \
		--disable-triplet
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	dohtml doc/index.html || die "failed to install html docs"
}

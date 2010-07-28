# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/punc/punc-0.2_p1.ebuild,v 1.4 2010/07/28 15:16:46 flameeyes Exp $

EAPI="3"

inherit autotools multilib

MY_PV="${PV}"
MY_P="${PN}-${MY_PV/_p/-}"

DESCRIPTION="Portable Understructure for Numerical Computing"
HOMEPAGE="http://fetk.org/codes/punc/index.html"
SRC_URI="http://www.fetk.org/codes/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug mpi static-libs"

DEPEND="
	dev-libs/maloc[mpi=]
	sci-libs/arpack[mpi=]
	sci-libs/superlu
	virtual/blas
	virtual/mpi"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

src_prepare() {
	rm -rf src/{blas,lapack,arpack,superlu}
	epatch "${FILESDIR}"/${PV}-underlinking.patch
	epatch "${FILESDIR}"/${P}-libdir.patch

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

	econf \
		$(use_enable static-libs static) \
		$(use_enable debug vdebug) \
		--enable-shared \
		--enable-pmgforce \
		--enable-cgcodeforce \
		--enable-vf2cforce
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	dohtml doc/index.html || die "failed to install html docs"
}

# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/punc/punc-1.5.ebuild,v 1.1 2011/04/16 07:32:52 jlec Exp $

EAPI="3"

inherit autotools multilib

DESCRIPTION="Portable Understructure for Numerical Computing"
HOMEPAGE="http://fetk.org/codes/punc/index.html"
SRC_URI="http://www.fetk.org/codes/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug doc mpi static-libs"

RDEPEND="
	dev-libs/maloc[mpi=]
	dev-libs/libf2c
	sci-libs/amd
	sci-libs/cgcode
	sci-libs/arpack[mpi=]
	sci-libs/superlu
	sci-libs/umfpack
	virtual/blas
	virtual/lapack
	mpi? ( virtual/mpi )"
DEPEND="
	${RDEPEND}
	doc? (
		media-gfx/graphviz
		app-doc/doxygen )"

S="${WORKDIR}/${PN}"

src_prepare() {
	rm -rf src/{amd,blas,lapack,arpack,superlu,umfpack}
	epatch \
		"${FILESDIR}"/${PV}-linking.patch \
		"${FILESDIR}"/1.4-doc.patch

	cp tools/tests/pmg/*.f src/pmg/ -f
	cp tools/tests/pmg/*.c src/pmg/ -f
	cp src/pmg/vpmg.h src/vf2c/punc/vpmg.h

	eautoreconf
}

src_configure() {
	local fetk_include
	local fetk_lib
	local myconf

	use doc || myconf="${myconf} --with-doxygen= --with-dot="

	fetk_include="${EPREFIX}"/usr/include
	fetk_lib="${EPREFIX}"/usr/$(get_libdir)
	export FETK_INCLUDE="${fetk_include}"
	export FETK_LIBRARY="${fetk_lib}"
	export FETK_LAPACK_LIBRARY="$(pkg-config --libs lapack)"
	export FETK_BLAS_LIBRARY="${fetk_lib}"
	export FETK_SUPERLU_LIBRARY="-lsuperlu"
	export FETK_ARPACK_LIBRARY="${fetk_lib}"
	export FETK_UMFPACK_LIBRARY="${fetk_lib}"
	export FETK_CGCODE_LIBRARY="${fetk_lib}"
	export FETK_AMD_LIBRARY="${fetk_lib}"

	econf \
		$(use_enable static-libs static) \
		$(use_enable debug vdebug) \
		--enable-shared \
		--docdir="${EPREFIX}"/usr/share/doc/${PF} \
		--disable-triplet \
		${myconf}
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	dohtml doc/index.html || die "failed to install html docs"
}

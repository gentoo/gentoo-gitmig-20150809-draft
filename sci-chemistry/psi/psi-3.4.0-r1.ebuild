# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/psi/psi-3.4.0-r1.ebuild,v 1.3 2011/06/21 15:58:04 jlec Exp $

EAPI="3"

inherit autotools fortran-2 eutils

DESCRIPTION="Suite of ab initio quantum chemistry programs to compute various molecular properties"
HOMEPAGE="http://www.psicode.org/"
SRC_URI="mirror://sourceforge/psicode/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

# File collision, see bug #249423
RDEPEND="
	virtual/fortran

	!sci-visualization/extrema
	virtual/blas
	virtual/lapack
	>=sci-libs/libint-1.1.4"
DEPEND="${RDEPEND}
	test? ( dev-lang/perl )"

S="${WORKDIR}/${PN}${PV:0:1}"

src_prepare() {
	epatch "${FILESDIR}"/${PV}-dont-build-libint.patch \
		"${FILESDIR}"/use-external-libint.patch \
		"${FILESDIR}"/${PV}-gcc-4.3.patch \
		"${FILESDIR}"/${PV}-destdir.patch \
		"${FILESDIR}"/${P}-parallel-make.patch \
		"${FILESDIR}"/${PV}-man_paths.patch \
		"${FILESDIR}"/${PV}-ldflags.patch \
		"${FILESDIR}"/${PV}-parallel_fix.patch

	# Broken test
	sed \
		-e 's:scf-mvd-opt ::g' \
		-e 's:scf-mvd-opt-puream ::g' \
		-i tests/Makefile.in || die

	sed \
		-e "/LIBPATTERNS/d" \
		-i src/{bin,util,samples}/MakeVars.in || die
	eautoreconf
}

src_configure() {
	# This variable gets set sometimes to /usr/lib/src and breaks stuff
	unset CLIBS

	econf \
		--with-opt="${CXXFLAGS}" \
		--datadir="${EPREFIX}"/usr/share/${PN} \
		--with-blas="$(pkg-config blas --libs)"
}

src_compile() {
	emake SCRATCH="${WORKDIR}/libint" DODEPEND="no" || die
}

src_test() {
	emake EXECDIR="${S}"/bin TESTFLAGS="" -j1 tests || die
}

src_install() {
	emake DESTDIR="${D}" DODEPEND="no" install || die
}

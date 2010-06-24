# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/psi/psi-3.4.0.ebuild,v 1.1 2010/06/24 21:08:01 jlec Exp $

EAPI="3"

inherit autotools eutils

DESCRIPTION="Suite of ab initio quantum chemistry programs to compute various molecular properties"
HOMEPAGE="http://www.psicode.org/"
SRC_URI="mirror://sourceforge/psicode/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

# File collision, see bug #249423
RDEPEND="
	!sci-visualization/extrema
	virtual/blas
	virtual/lapack
	>=sci-libs/libint-1.1.4"
DEPEND="${RDEPEND}
	test? ( dev-lang/perl )"

S="${WORKDIR}/${PN}${PV:0:1}"

src_prepare() {
	epatch "${FILESDIR}"/${PV}-dont-build-libint.patch
	epatch "${FILESDIR}"/use-external-libint.patch
	epatch "${FILESDIR}"/${PV}-gcc-4.3.patch
	epatch "${FILESDIR}"/${PV}-destdir.patch
	epatch "${FILESDIR}"/${P}-parallel-make.patch
	sed "s:^LDFLAGS=:LDFLAGS=${LDFLAGS}:g" -i configure.ac || die
	# Broken test
	sed \
		-e 's:scf-mvd-opt ::g' \
		-e 's:scf-mvd-opt-puream ::g' \
		-i tests/Makefile.in || die
	eautoreconf
}

src_configure() {
	# This variable gets set sometimes to /usr/lib/src and breaks stuff
	unset CLIBS

	econf \
		--with-opt="${CFLAGS}" \
		--datadir="${EPREFIX}"/usr/share/${PN} \
		--with-blas="$(pkg-config blas --libs)"
}

src_compile() {
	emake -j1 \
		SCRATCH="${WORKDIR}/libint" \
		|| die "make failed"
}

src_test() {
	emake \
		EXECDIR="${S}"/bin \
		TESTFLAGS="" \
		-j1 tests || die
}

src_install() {
	emake -j1 \
		DESTDIR="${D}" \
		install || die "install failed"
}

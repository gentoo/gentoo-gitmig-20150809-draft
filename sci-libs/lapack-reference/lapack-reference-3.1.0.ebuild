# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/lapack-reference/lapack-reference-3.1.0.ebuild,v 1.5 2007/03/24 14:21:22 corsair Exp $

inherit autotools eutils fortran multilib

MyPN="${PN/-reference/}"

DESCRIPTION="FORTRAN reference implementation of LAPACK Linear Algebra PACKage"
LICENSE="BSD"
HOMEPAGE="http://www.netlib.org/lapack/index.html"
SRC_URI="http://www.netlib.org/lapack/${MyPN}-lite-${PV}.tgz"

SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~ppc ppc64 sparc x86"

RDEPEND="virtual/blas
	app-admin/eselect-lapack"

DEPEND="${RDEPEND}"

PROVIDE="virtual/lapack"

FORTRAN="g77 gfortran ifc"

S="${WORKDIR}/${MyPN}-${PV}"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${P}-autotool.patch
	cd "${S}"
	eautoreconf

	# set up the testing routines
	cp make.inc.example make.inc || die "Failed to copy make.inc"
	sed -e "s:g77:${FORTRANC}:" \
		-e "s:-funroll-all-loops -O3:${FFLAGS}:" \
		-e "s:LOADOPTS =:LOADOPTS = ${LDFLAGS}:" \
		-e "s:../../blas\$(PLAT).a:/usr/$(get_libdir)/libblas.so:" \
		-e "s:lapack\$(PLAT).a:SRC/.libs/liblapack.a:" \
		-i make.inc || die "Failed to set up make.inc"
}

src_install() {
	TOP_PATH="${DESTTREE}"/lib/lapack
	# Library will be installed in RPATH:
	RPATH="${TOP_PATH}"/reference

	make DESTDIR="${D}" install || die "install failed"

	# Fix for switching
	dodir ${RPATH}
	mv ${D}/usr/$(get_libdir)/liblapack* ${D}/${RPATH}

	dodoc "${S}"/README

	eselect lapack add $(get_libdir) ${FILESDIR}/eselect-reference reference
}

src_test() {
	cd TESTING/MATGEN && emake || die "Failed to create tmglib.a"
	cd ../ && emake || die "lapack-reference tests failed."
}

pkg_postinst() {
	if [[ -z "$(eselect lapack show)" ]]; then
		eselect lapack set reference
	fi

	elog "Configuration now uses eselect rather than lapack-config."
}

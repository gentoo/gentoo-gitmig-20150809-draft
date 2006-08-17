# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/lapack-reference/lapack-reference-3.0-r4.ebuild,v 1.2 2006/08/17 20:10:29 dberkholz Exp $

inherit autotools eutils fortran multilib

MyPN="${PN/-reference/}"

DESCRIPTION="FORTRAN reference implementation of LAPACK Linear Algebra PACKage"
LICENSE="lapack"
HOMEPAGE="http://www.netlib.org/lapack/index.html"
SRC_URI="http://www.netlib.org/lapack/${MyPN}.tgz
	mirror://gentoo/${MyPN}-20020531-20021004.patch.bz2"

SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"

RDEPEND="virtual/blas
	app-admin/eselect-lapack"

DEPEND="${RDEPEND}"

PROVIDE="virtual/lapack"

FORTRAN="g77 gfortran ifc"

S="${WORKDIR}/LAPACK"

src_unpack() {
	unpack ${A}
	epatch "${DISTDIR}"/lapack-20020531-20021004.patch.bz2
	epatch ${FILESDIR}/${P}-autotool.patch
	cd "${S}"
	eautoreconf
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

pkg_postinst() {
	if [[ -z "$(eselect lapack show)" ]]; then
		eselect lapack set reference
	fi

	elog "Configuration now uses eselect rather than lapack-config."
}

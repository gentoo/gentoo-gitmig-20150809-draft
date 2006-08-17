# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/cblas-reference/cblas-reference-20030223-r2.ebuild,v 1.2 2006/08/17 20:09:41 dberkholz Exp $

inherit autotools eutils fortran multilib

MyPN="${PN/-reference/}"

DESCRIPTION="C interface to the BLAS"
LICENSE="public-domain"
HOMEPAGE="http://www.netlib.org/blas/"
SRC_URI="http://www.netlib.org/blas/blast-forum/${MyPN}.tgz"

SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"

RDEPEND="virtual/blas
	app-admin/eselect-cblas"
DEPEND="${RDEPEND}"

FORTRAN="gfortran g77 ifc"

S="${WORKDIR}/CBLAS"

src_unpack() {
	unpack ${A}
	# Must patch before changing to S. Patches that create new files
	# will happily apply anywhere.
	epatch "${FILESDIR}"/${P}-autotool.patch
	cd "${S}"
	eautoreconf
}

src_install() {
	TOP_PATH="${DESTTREE}/$(get_libdir)/blas"
	RPATH="${TOP_PATH}/reference"

	make DESTDIR="${D}" install || die "install failed"

	# Fix for switching
	dodir ${RPATH}
	mv ${D}/usr/$(get_libdir)/libcblas* ${D}/${RPATH}

	dodoc "${S}"/README || die "failed to install docs"

	eselect cblas add $(get_libdir) ${FILESDIR}/eselect-reference reference
}

pkg_postinst() {
	if [[ -z "$(eselect cblas show)" ]]; then
		eselect cblas set reference
	fi

	elog "Configuration now uses eselect rather than blas-config."
}

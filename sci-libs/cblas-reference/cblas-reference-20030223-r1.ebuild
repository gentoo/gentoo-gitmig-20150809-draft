# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/cblas-reference/cblas-reference-20030223-r1.ebuild,v 1.5 2007/08/21 16:46:48 bicatali Exp $

inherit autotools eutils fortran multilib

MyPN="${PN/-reference/}"

DESCRIPTION="C interface to the BLAS"
LICENSE="public-domain"
HOMEPAGE="http://www.netlib.org/blas/"
SRC_URI="http://www.netlib.org/blas/blast-forum/${MyPN}.tgz"

SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~ppc ~ppc64 x86"

RDEPEND="virtual/blas
	sci-libs/blas-config"
DEPEND="${RDEPEND}"

FORTRAN="gfortran g77 ifc"

S="${WORKDIR}/CBLAS"

src_unpack() {
	unpack ${A}
	# Must patch before changing to S. Patches that create new files
	# will happily apply anywhere.
	cd "${S}"
	epatch "${FILESDIR}"/${P}-autotool.patch
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

	insinto "${TOP_PATH}"
	doins "${FILESDIR}"/c-reference || \
		die "failed to install blas-config file"
}

pkg_postinst() {
	blas-config c-reference
}

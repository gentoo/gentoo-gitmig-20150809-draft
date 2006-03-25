# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/cblas-reference/cblas-reference-20030223.ebuild,v 1.1 2006/03/25 13:07:35 markusle Exp $

inherit eutils fortran multilib

MyPN="${PN/-reference/}"

DESCRIPTION="C interface to the BLAS"
LICENSE="public-domain"
HOMEPAGE="http://www.netlib.org/blas/"
SRC_URI="http://www.netlib.org/blas/blast-forum/${MyPN}.tgz"

SLOT="0"
IUSE=""
KEYWORDS="~x86"

DEPEND="sys-devel/libtool
		virtual/blas
		sci-libs/blas-config"

FORTRAN="gfortran g77 ifc"

S="${WORKDIR}/CBLAS"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/cblas-gentoo.patch
}

src_compile() {
	TOP_PATH="${DESTTREE}/$(get_libdir)/blas"
	RPATH="${TOP_PATH}/cblas-reference"
	cd "${S}"/src

	make all FC="libtool --mode=compile --tag=F77 ${FORTRANC}" \
		FFLAGS="${FFLAGS}" CC="libtool --mode=compile --tag=CC gcc" \
		CFLAGS="${CFLAGS} -DADD_" || die "make failed"

	libtool --mode=link --tag=F77 ${FORTRANC} -o libcblas.la *.lo \
		-rpath "${RPATH}" || die "failed to link static libraries"
	libtool --mode=link --tag=F77 ${FORTRANC} -shared *.lo \
		-Wl,-soname -Wl,libcblas.so.0 -o libcblas.so.0.0.0 || \
		die "failed to link shared libraries"
}

src_install() {
	dodir "${RPATH}" || die "failed to create lib directory"

	cd "${S}"/src

	libtool --mode=install install -s libcblas.la "${D}/${RPATH}"\
		|| die "failed to install static library"

	insinto "${DESTTREE}"/include/${PN}
	doins cblas_f77.h cblas.h || die "failed to install header files"

	dodoc "${S}"/README || die "failed to install docs"

	insinto "${TOP_PATH}"
	doins "${FILESDIR}"/c-reference || \
		die "failed to install blas-config file"
}

pkg_postinst() {
	    blas-config c-reference
}

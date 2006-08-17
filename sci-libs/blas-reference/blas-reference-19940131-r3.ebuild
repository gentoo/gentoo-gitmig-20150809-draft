# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/blas-reference/blas-reference-19940131-r3.ebuild,v 1.3 2006/08/17 20:13:31 dberkholz Exp $

inherit autotools fortran multilib

Name="blas"
DESCRIPTION="FORTRAN reference implementation of the BLAS (linear algebra lib)"
LICENSE="public-domain"
HOMEPAGE="http://www.netlib.org/blas/"
SRC_URI="http://www.netlib.org/blas/${Name}.tgz"

SLOT="0"
IUSE=""
KEYWORDS="~amd64 ppc ~ppc64 x86"

RDEPEND="sci-libs/blas-config"
DEPEND="${RDEPEND}"

PROVIDE="virtual/blas"

#TODO: detect 64bit size from compiler, not eclass
FORTRAN="g77 gfortran ifc" || FORTRAN="g77 gfortran f2c ifc" # No f2c on 64-bit systems yet :-/

S="${WORKDIR}"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-autotool.patch
	cd "${S}"
	eautoreconf
}

src_install() {
	# Profile information will be installed in TOP_PATH:
	TOP_PATH="${DESTTREE}"/$(get_libdir)/blas
	# Libraries will be installed in RPATH:
	RPATH="${TOP_PATH}"/reference

	make DESTDIR="${D}" install || die "install failed"

	# Fix for switching
	dodir ${RPATH}
	mv ${D}/usr/$(get_libdir)/libblas* ${D}/${RPATH}

	insinto ${TOP_PATH}
	doins ${FILESDIR}/f77-reference || die
}

pkg_postinst() {
	blas-config f77-reference
}

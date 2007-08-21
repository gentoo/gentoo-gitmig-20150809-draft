# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/blas-reference/blas-reference-20070226.ebuild,v 1.4 2007/08/21 18:09:57 jer Exp $

inherit eutils autotools fortran multilib flag-o-matic

LAPACKPV="3.1.1"
LAPACKPN="lapack-lite"

DESCRIPTION="Basic Linear Algebra Subprograms F77 reference implementations"
LICENSE="public-domain"
HOMEPAGE="http://www.netlib.org/blas/"
SRC_URI="http://www.netlib.org/lapack/${LAPACKPN}-${LAPACKPV}.tgz"

SLOT="0"
IUSE="doc"
KEYWORDS="~amd64 hppa sparc ~x86"

DEPEND="app-admin/eselect-blas
	doc? ( app-doc/blas-docs )"

RDEPEND="${DEPEND}
	dev-util/pkgconfig"

PROVIDE="virtual/blas"

S="${WORKDIR}/${LAPACKPN}-${LAPACKPV}"

pkg_setup() {
	FORTRAN="g77 gfortran f2c ifc"
	fortran_pkg_setup
	if  [[ ${FORTRANC:0:2} == "if" ]]; then
		ewarn "Using Intel Fortran at your own risk"
		LDFLAGS="$(raw-ldflags)"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-autotool.patch
	eautoreconf
}

src_compile() {
	econf \
		--libdir=/usr/$(get_libdir)/blas/reference \
		|| die "econf failed"
	emake LDFLAGS="${LDFLAGS}" || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	eselect blas add $(get_libdir) "${FILESDIR}"/eselect.blas.reference reference
}

pkg_postinst() {
	[[ -z "$(eselect blas show)" ]] && eselect blas set reference
	elog "To use BLAS reference implementation, you have to issue (as root):"
	elog "\t eselect blas set reference"
}

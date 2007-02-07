# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/numeric/numeric-24.2-r2.ebuild,v 1.1 2007/02/07 17:21:10 bicatali Exp $

inherit distutils eutils fortran

MY_P=Numeric-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Numerical multidimensional array language facility for Python."
HOMEPAGE="http://numeric.scipy.org/"
SRC_URI="mirror://sourceforge/numpy/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="lapack"
DEPEND=">=dev-lang/python-2.3
	lapack? ( virtual/cblas virtual/lapack )"

pkg_setup() {
	if use lapack; then
		FORTRAN="gfortran g77"
		fortran_pkg_setup
	fi
}

src_unpack() {
	if use lapack; then
		fortran_src_unpack
	else
		unpack ${A}
	fi
	# fix list problem
	epatch "${FILESDIR}"/${P}-arrayobject.patch
	# fix skips of acosh, asinh
	epatch "${FILESDIR}"/${P}-umath.patch
	# fix eigenvalue hang
	epatch "${FILESDIR}"/${P}-eigen.patch
	# adapt lapack support
	if use lapack; then
		epatch "${FILESDIR}"/${P}-lapack.patch
		if  [[ ${FORTRANC} == gfortran ]]; then
			sed -i -e 's:g2c:gfortran:g' ${S}/customize.py
		fi
	fi
}

src_install() {
	distutils_src_install
	distutils_python_version

	# Numerical Tutorial is nice for testing and learning
	insinto /usr/$(get_libdir)/python${PYVER}/site-packages/NumTut
	doins Demo/NumTut/*

	# install various doc from packages
	docinto FFT
	dodoc Packages/FFT/MANIFEST
	docinto MA
	dodoc Packages/MA/{MANIFEST,README}
	docinto RNG
	dodoc Packages/RNG/{MANIFEST,README}
	docinto lapack_lite
	dodoc Misc/lapack_lite/README
	if use lapack; then
		docinto dotblas
		dodoc Packages/dotblas/{README,profileDot}.txt
		insinto /usr/share/doc/${PF}/dotblas
		doins Packages/dotblas/profileDot.py
	fi
}

# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/numeric/numeric-24.2-r1.ebuild,v 1.1 2007/02/07 17:14:57 bicatali Exp $

inherit distutils eutils

MY_P=Numeric-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Numerical multidimensional array language facility for Python."
HOMEPAGE="http://numeric.scipy.org/"
SRC_URI="mirror://sourceforge/numpy/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND=">=dev-lang/python-2.3"


src_unpack() {
	unpack ${A}
	# fix list problem
	epatch "${FILESDIR}"/${P}-arrayobject.patch
	# fix skips of acosh, asinh
	epatch "${FILESDIR}"/${P}-umath.patch
	# fix eigenvalue hang
	epatch "${FILESDIR}"/${P}-eigen.patch
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
}

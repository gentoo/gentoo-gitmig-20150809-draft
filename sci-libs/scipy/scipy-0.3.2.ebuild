# Copyright 2005-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/scipy/scipy-0.3.2.ebuild,v 1.1 2005/08/22 16:31:29 pbienst Exp $

inherit distutils

MY_P="SciPy_complete-${PV}"
SRC_URI="http://www.scipy.org/download/scipy/src/${MY_P}.tar.gz"
DESCRIPTION="Open source scientific tools for Python"
HOMEPAGE="http://www.scipy.org/"
LICENSE="BSD"

SLOT="0"
IUSE="fftw wxwindows"
KEYWORDS="~x86"
S="${WORKDIR}/${MY_P}"

DEPEND=">=dev-lang/python-2.3.3
	>=dev-python/numeric-21.0
	>=sys-devel/gcc-3
	virtual/lapack
	virtual/blas
	>=dev-python/f2py-2.39.235.1644
	fftw? ( =sci-libs/fftw-2.1* )
	wxwindows? ( >=dev-python/wxpython-2.4 )"

RDEPEND=">=dev-lang/python-2.3.3
	>=dev-python/numeric-21.0
	virtual/lapack
	virtual/blas
	fftw? ( =sci-libs/fftw-2.1* )
	wxwindows? ( >=dev-python/wxpython-2.4 )"

src_unpack() {
	if [ -z `which g77` ]; then
		eerror "No Fortran compiler found on the system!"
		eerror "Please add fortran to your USE flags and reemerge gcc!"
		die
	fi
	unpack ${A} || die
	cd ${S}
	epatch ${FILESDIR}/system_info.diff
}

src_test() {
	einfo "Testing installation ..."
	python -c "import scipy; scipy.test(level=1)" || \
		die "Unit tests failed!"
}

src_install() {
	distutils_src_install
	dodoc `ls *.txt`
}

pkg_postinst() {
	distutils_pkg_postinst

	einfo ""
	einfo "Emerge media-gfx/gnuplot to use the 'gplt' plotting facility."
	if use wxwindows; then
		einfo "Set USE=wxwindows and reemerge to use the newer 'plt' plotter."
	fi
	einfo ""
}

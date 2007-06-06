# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/scipy/scipy-0.5.2-r2.ebuild,v 1.1 2007/06/06 21:27:52 bicatali Exp $

NEED_PYTHON=2.3

inherit eutils distutils fortran

SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
DESCRIPTION="Scientific algorithms library for Python"
HOMEPAGE="http://www.scipy.org/"
LICENSE="BSD"

SLOT="0"

IUSE="fftw umfpack sandbox"

KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-python/numpy-1.0
	virtual/blas
	virtual/lapack
	fftw? ( =sci-libs/fftw-2.1* )
	umfpack? ( sci-libs/umfpack )
	sandbox? ( >=sci-libs/netcdf-3.6 x11-libs/libX11 )"

DEPEND="${RDEPEND}
	umfpack? ( dev-lang/swig )"

FORTRAN="gfortran g77"

# test still buggy on lapack, remove when OK (check each new version)
RESTRICT="test"

DOCS="THANKS.txt DEVELOPERS.txt LATEST.txt TOCHANGE.txt FORMAT_GUIDELINES.txt"

scipy_configure() {
	[[ -z "${FFLAGS}" ]] && FFLAGS="${CFLAGS}"
	# scipy automatically detects libraries by default
	export FFTW=None FFTW3=None UMFPACK=None DJBFFT=None
	use fftw && unset FFTW
	use umfpack && unset UMFPACK
	# Map compilers to what numpy calls them (same as scipy)
	case "${FORTRANC}" in
		gfortran)
			SCIPY_FC="gnu95"
			;;
		g77)
			SCIPY_FC="gnu"
			;;
		ifc|ifort)
			if use ia64; then
				SCIPY_FC="intele"
			elif use amd64; then
				SCIPY_FC="intelem"
			else
				SCIPY_FC="intel"
			fi
			;;
		*)
			local msg="Invalid Fortran compiler \'${FORTRANC}\'"
			eerror "${msg}"
			die "${msg}"
			;;
	esac
	export SCIPY_FC

	# http://projects.scipy.org/scipy/numpy/ticket/182
	# Can't set LDFLAGS
	unset LDFLAGS
	# need to build with -fPIC (bug #149153)
	export F77FLAGS="${F77FLAGS} -fPIC"
}

pkg_setup() {
	if use umfpack && ! built_with_use dev-lang/swig python; then
		eerror "With umfpack enabled you need"
		eerror "dev-lang/swig with python enabled"
		einfo  "Please re-emerge swig with USE=python"
		die "needs swig with python"
	fi
	fortran_pkg_setup
	use sandbox && elog "Warning: using sandbox modules at your own risk!"
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	# most of these patches should be useless in versions >=0.5.3)
	# various patches from scipy svn and to allow sandbox modules
	epatch "${FILESDIR}"/${P}-signals.patch
	epatch "${FILESDIR}"/${P}-viewer.patch
	epatch "${FILESDIR}"/${P}-randomkit.patch
	epatch "${FILESDIR}"/${P}-umfpack.patch
	epatch "${FILESDIR}"/${P}-montecarlo-test.patch
	epatch "${FILESDIR}"/${P}-mio.patch
	epatch "${FILESDIR}"/${P}-minpack.patch
	epatch "${FILESDIR}"/${P}-bspline.patch
	has_version ">=dev-python/numpy-1.0.3" && epatch "${FILESDIR}"/${P}-getpath.patch
	# following patch still not fixed in svn
	epatch "${FILESDIR}"/${P}-nonexisting.patch
	# fix test (use a sed instead of big patch)
	einfo "Fixing tests"
	find Lib -name \*.py -exec grep -l ScipyTest '{}' \; | \
		xargs sed -i -e 's/ScipyTest/NumpyTest/g' \
		|| die "sed failed"
	use sandbox && cp "${FILESDIR}"/enabled_packages.txt Lib/sandbox/
	#use sandbox && cp "${FILESDIR}"/_bspline.cpp .
}

src_compile() {
	scipy_configure
	distutils_src_compile \
		config_fc \
		--fcompiler="${SCIPY_FC}" \
		--opt="${FFLAGS}"
}

src_test() {
	scipy_configure
	${python} setup.py install \
		--home="${S}"/test \
		--no-compile \
	    config_fc \
	    --fcompiler=${SCIPY_FC} \
	    --opt="${FFLAGS}" || die "install test failed"
	pushd "${S}"/test/lib*/python
	PYTHONPATH=. "${python}" -c \
		"import scipy as s;import sys;sys.exit(s.test(10,3))"  \
		> test.log 2>&1
	grep -q OK test.log || die "test failed"
	popd
	rm -rf test
}

src_install() {
	scipy_configure
	distutils_src_install \
		config_fc \
		--fcompiler="${SCIPY_FC}" \
		--opt="${FFLAGS}"
}

pkg_postinst() {
	elog "You might want to set the variable SCIPY_PIL_IMAGE_VIEWER"
	elog "to your prefered image viewer if you don't like the default one. Ex:"
	elog "\t echo \"export SCIPY_PIL_IMAGE_VIEWER=display\" >> ~/.bashrc"
}

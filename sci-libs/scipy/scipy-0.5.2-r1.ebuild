# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/scipy/scipy-0.5.2-r1.ebuild,v 1.1 2007/02/19 11:09:36 bicatali Exp $

NEED_PYTHON=2.3

inherit distutils fortran

SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
DESCRIPTION="Scientific algorithms library for Python"
HOMEPAGE="http://www.scipy.org/"
LICENSE="BSD"

SLOT="0"

IUSE="fftw umfpack"

KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-python/numpy-1.0
	virtual/blas
	virtual/lapack
	fftw? ( sci-libs/fftw )
	umfpack? ( sci-libs/umfpack )"

DEPEND="${RDEPEND}
	umfpack? ( dev-lang/swig )"

RESTRICT="test"

FORTRAN="gfortran g77"

DOCS="THANKS.txt DEVELOPERS.txt LATEST.txt TOCHANGE.txt FORMAT_GUIDELINES.txt"

scipy_configure() {
	[[ -z "${FFLAGS}" ]] && FFLAGS="${CFLAGS}"
	# scipy automatically detects libraries by default
	export FFTW=None FFTW3=None UMFPACK=None DJBFFT=None
	use fftw && unset FFTW FFTW3
	use umfpack && unset UMFPACK
	# Map compilers to what numpy calls them (same as scipy)
	case "${FORTRANC}" in
		gfortran)
			SCIPY_FC="gnu95"
			;;
		g77)
			SCIPY_FC="gnu"
			;;
		g95)
			SCIPY_FC="g95"
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
	if use umfpack; then
		if ! built_with_use dev-lang/swig python; then
			eerror "With umfpack enabled you need"
			eerror "dev-lang/swig with python enabled"
			einfo  "Please re-emerge swig with USE=python"
			die "needs swig with python"
		fi
	fi
	fortran_pkg_setup
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

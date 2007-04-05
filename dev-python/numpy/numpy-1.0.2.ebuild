# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/numpy/numpy-1.0.2.ebuild,v 1.1 2007/04/05 10:32:11 bicatali Exp $

NEED_PYTHON=2.3

inherit distutils eutils fortran

MY_P=${P/_beta/b}
MY_P=${MY_P/_}
DESCRIPTION="Python array processing for numbers, strings, records, and objects"
SRC_URI="mirror://sourceforge/numpy/${MY_P}.tar.gz"
HOMEPAGE="http://numeric.scipy.org/"

RDEPEND="!dev-python/f2py
	lapack? ( || ( >=sci-libs/blas-atlas-3.7.11-r1
				   >=sci-libs/cblas-reference-20030223-r3 )
				  virtual/lapack )"
DEPEND="${RDEPEND}
	lapack? ( app-admin/eselect-cblas )"

IUSE="lapack"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
LICENSE="BSD"

S="${WORKDIR}/${MY_P}"

FORTRAN="g77 gfortran"

numpy_configure() {
	local mycblas
	if use lapack; then
		for d in $(eselect cblas show); do mycblas=${d}; done
		if [[ -z "${mycblas/reference/}" ]] && [[ -z "${mycblas/atlas/}" ]]; then
			ewarn "You need to set cblas to atlas or reference. Do:"
			ewarn "   eselect cblas set <impl>"
			ewarn "where <impl> is atlas, threaded-atlas or reference"
			die "setup failed"
		fi
	fi
	[[ -z "${F77FLAGS}" ]] && F77FLAGS="${CFLAGS}"
	[[ -z "${FFLAGS}" ]] && FFLAGS="${F77FLAGS}"

	# remove default values
	echo "# gentoo config" > site.cfg

	export BLAS=None
	export LAPACK=None
	export ATLAS=None
	export PTATLAS=None
	export MKL=None

	if use lapack; then
		echo "[blas_opt]"  >> site.cfg
		case "${mycblas}" in
			reference)
				echo "include_dirs = /usr/include/cblas" >> site.cfg
				echo "libraries = blas, cblas" >> site.cfg
				unset BLAS
				;;
			atlas|threaded-atlas)
				echo "include_dirs = /usr/include/atlas" >> site.cfg
				echo "libraries = blas, cblas, atlas" >> site.cfg
				unset ATLAS
				;;
			*)
				local msg="Invalid cblas implementation: ${cblas}"
				eerror "${msg}"
				die "${msg}"
				;;
		esac
		echo "[lapack_opt]"  >> site.cfg
		echo "libraries = lapack" >> site.cfg
		unset LAPACK
	fi
	# Map compilers to what numpy calls them (same as scipy)
	case "${FORTRANC}" in
		gfortran)
			NUMPY_FC="gnu95"
			;;
		g77)
			NUMPY_FC="gnu"
			;;
		g95)
			NUMPY_FC="g95"
			;;
		ifc|ifort)
			if use ia64; then
				NUMPY_FC="intele"
			elif use amd64; then
				NUMPY_FC="intelem"
			else
				NUMPY_FC="intel"
			fi
			;;
		*)
			local msg="Invalid Fortran compiler \'${FORTRANC}\'"
			eerror "${msg}"
			die "${msg}"
			;;
	esac
	export NUMPY_FC
	# http://projects.scipy.org/scipy/numpy/ticket/182
	# Can't set LDFLAGS
	unset LDFLAGS
}

src_unpack() {
	fortran_src_unpack
	cd "${S}"
	# fix some paths and docs in f2py
	epatch "${FILESDIR}"/${PN}-1.0.1-f2py.patch

	# gentoo patch for ATLAS library names
	sed -i \
		-e "s:'f77blas':'blas':g" \
		-e "s:'ptblas':'blas':g" \
		-e "s:'ptcblas':'cblas':g" \
		-e "s:'lapack_atlas':'lapack':g" \
		numpy/distutils/system_info.py
}

src_compile() {
	numpy_configure
	distutils_src_compile \
	    config_fc \
	    --fcompiler=${NUMPY_FC} \
	    --opt="${FFLAGS}"
}

src_test() {
	# see comment before the distutils_src_install
	numpy_configure
	${python} setup.py install \
		--home="${S}"/test \
		--no-compile \
	    config_fc \
	    --fcompiler=${NUMPY_FC} \
	    --opt="${FFLAGS}" || die "install test failed"
	pushd "${S}"/test/lib*/python
	PYTHONPATH=. "${python}" -c \
		"import numpy as n;import sys;sys.exit(n.test(10,3))"  \
		> test.log 2>&1
	grep -q OK test.log || die "test failed"
	popd
	rm -rf test
}

src_install() {
	# we need to do the configuring again, for some reason, the
	# variables are not kept within setup.py functions
	numpy_configure
	distutils_src_install \
	    config_fc \
	    --fcompiler=${NUMPY_FC} \
	    --opt="${FFLAGS}"

	docinto numpy
	dodoc numpy/doc/*txt
	docinto f2py
	dodoc numpy/f2py/docs/*txt
	doman numpy/f2py/f2py.1
}

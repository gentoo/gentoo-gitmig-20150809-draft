# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/numpy/numpy-1.0.1.ebuild,v 1.1 2007/01/31 08:36:28 nerdboy Exp $

inherit distutils fortran

MY_P=${P/_beta/b}
MY_P=${MY_P/_}
DESCRIPTION="Multi-dimensional array object and processing for Python."
SRC_URI="mirror://sourceforge/numpy/${MY_P}.tar.gz"
HOMEPAGE="http://numeric.scipy.org/"

# numpy provides the latest version of dev-python/f2py
DEPEND=">=dev-lang/python-2.3
	!dev-python/f2py
	lapack? ( virtual/blas
		virtual/lapack )"

IUSE="lapack"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
LICENSE="BSD"
RESTRICT="test"
S="${WORKDIR}/${MY_P}"

FORTRAN="g77 gfortran"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# sed to patch ATLAS libraries names (gentoo specific)
	sed -i \
		-e "s:f77blas:blas:g" \
		-e "s:ptblas:blas:g" \
		-e "s:ptcblas:cblas:g" \
		-e "s:lapack_atlas:lapack:g" \
		numpy/distutils/system_info.py

	if use lapack; then
		echo "[atlas]"  > site.cfg
		echo "include_dirs = /usr/include/atlas" >> site.cfg
		echo "atlas_libs = lapack, blas, cblas, atlas" >> site.cfg
		echo -n "library_dirs = /usr/$(get_libdir)/lapack::/usr/$(get_libdir):" \
			>> site.cfg
		if [ -d "/usr/$(get_libdir)/blas/threaded-atlas" ]; then
			echo "/usr/$(get_libdir)/blas/threaded-atlas" >> site.cfg
		else
			echo "/usr/$(get_libdir)/blas/atlas" >> site.cfg
		fi
	fi
}

src_compile() {
	# Map compilers to what numpy calls them (same as scipy)
	local NUMPY_FC
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

	if !(use lapack); then
		rm -f site.cfg
		export BLAS=None
		export LAPACK=None
		export ATLAS=None
	fi
	
	# http://projects.scipy.org/scipy/numpy/ticket/182
	# Can't set LDFLAGS
	unset LDFLAGS
	export F77LFLAGS="${F77LFLAGS} -fPIC"

	distutils_src_compile \
	    config_fc \
	    --fcompiler=${NUMPY_FC} \
	    --opt="${CFLAGS}" \
	    || die "compilation failed"
}

src_install() {
	distutils_src_install
	dodoc numpy/doc/*
}

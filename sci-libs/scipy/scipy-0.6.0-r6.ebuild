# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/scipy/scipy-0.6.0-r6.ebuild,v 1.1 2009/01/14 18:11:57 bicatali Exp $

EAPI=2
NEED_PYTHON=2.3
inherit eutils distutils fortran flag-o-matic

SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
DESCRIPTION="Scientific algorithms library for Python"
HOMEPAGE="http://www.scipy.org/"
LICENSE="BSD"

SLOT="0"

IUSE="fftw umfpack sandbox"

KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"

CDEPEND="dev-python/numpy
	virtual/cblas
	virtual/lapack
	fftw? ( sci-libs/fftw:2.1 )
	umfpack? ( sci-libs/umfpack )
	sandbox? ( >=sci-libs/netcdf-3.6 x11-libs/libX11 )"

DEPEND="${CDEPEND}
	dev-util/pkgconfig
	umfpack? ( dev-lang/swig[python] )"

RDEPEND="${CDEPEND}
	dev-python/imaging"

# test still buggy on lapack with 2 failures on check_syevr
# (lapack float). check every version bump.
#RESTRICT="test"

DOCS="THANKS.txt DEVELOPERS.txt LATEST.txt TOCHANGE.txt FORMAT_GUIDELINES.txt"

scipy_fortran_setup() {
	append-ldflags -shared
	FORTRAN="gfortran g77 ifc"
	fortran_pkg_setup
	local fc=
	case ${FORTRANC} in
		gfortran) fc=gnu95 ;;
		g77) fc=gnu ;;
		ifc|ifort)
			if use ia64; then
				fc=intele
			elif use amd64; then
				fc=intelem
			else
				fc=intel
			fi
			;;
		*)	eerror "Unknown fortran compiler: ${FORTRANC}"
			die "scipy_fortran_setup failed" ;;
	esac
	export SCIPY_FCONFIG="config_fc --fcompiler=${fc} --noopt --noarch"
}

pkg_setup() {
	# scipy automatically detects libraries by default
	export {FFTW,FFTW3,UMFPACK}=None
	use fftw && unset FFTW
	use umfpack && unset UMFPACK
	use sandbox && elog "Warning: using sandbox modules at your own risk!"
	scipy_fortran_setup
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-implicit.patch
	epatch "${FILESDIR}"/${P}-randomkit.patch
	epatch "${FILESDIR}"/${P}-cdf.patch
	epatch "${FILESDIR}"/${P}-fftw-fix.patch
	epatch "${FILESDIR}"/${P}-ndimage.patch
	epatch "${FILESDIR}"/${P}-python-2.6-c_abs.patch
	epatch "${FILESDIR}"/${P}-stsci.patch
	cat > site.cfg <<-EOF
		[DEFAULT]
		library_dirs = /usr/$(get_libdir)
		include_dirs = /usr/include
		[atlas]
		include_dirs = $(pkg-config --cflags-only-I \
			cblas | sed -e 's/^-I//' -e 's/ -I/:/g')
		library_dirs = $(pkg-config --libs-only-L \
			cblas blas lapack| sed -e \
			's/^-L//' -e 's/ -L/:/g' -e 's/ //g'):/usr/$(get_libdir)
		atlas_libs = $(pkg-config --libs-only-l \
			cblas blas | sed -e 's/^-l//' -e 's/ -l/, /g' -e 's/,.pthread//g')
		lapack_libs = $(pkg-config --libs-only-l \
			lapack | sed -e 's/^-l//' -e 's/ -l/, /g' -e 's/,.pthread//g')
		[blas_opt]
		include_dirs = $(pkg-config --cflags-only-I \
			cblas | sed -e 's/^-I//' -e 's/ -I/:/g')
		library_dirs = $(pkg-config --libs-only-L \
			cblas blas | sed -e 's/^-L//' -e 's/ -L/:/g' \
			-e 's/ //g'):/usr/$(get_libdir)
		libraries = $(pkg-config --libs-only-l \
			cblas blas | sed -e 's/^-l//' -e 's/ -l/, /g' -e 's/,.pthread//g')
		[lapack_opt]
		library_dirs = $(pkg-config --libs-only-L \
			lapack | sed -e 's/^-L//' -e 's/ -L/:/g' \
			-e 's/ //g'):/usr/$(get_libdir)
		libraries = $(pkg-config --libs-only-l \
			lapack | sed -e 's/^-l//' -e 's/ -l/, /g' -e 's/,.pthread//g')
	EOF
	if use sandbox; then
		cd scipy/sandbox
		ls -1 */__init__.py \
			| sed -e 's:/__init__.py::' \
			| grep -v exmplpackage \
			> enabled_packages.txt \
			|| die "sandbox listing failed"
	fi
}

src_compile() {
	# when fortran flags are set, pic is removed.
	[[ -n ${FFLAGS} ]] && FFLAGS="${FFLAGS} -fPIC"
	distutils_src_compile ${SCIPY_FCONFIG}
}

src_test() {
	"${python}" setup.py install \
		--home="${S}"/test \
		--no-compile \
		${SCIPY_FCONFIG} || die "install test failed"
	pushd "${S}"/test/lib*/python
	PYTHONPATH=. "${python}" -c \
		"import scipy as s;import sys;sys.exit(s.test(10,3))" \
		 2>&1 | tee test.log
	grep -q OK test.log || die "test failed"
	popd
	rm -rf test
}

src_install() {
	distutils_src_install ${SCIPY_FCONFIG}
}

pkg_postinst() {
	elog "You might want to set the variable SCIPY_PIL_IMAGE_VIEWER"
	elog "to your prefered image viewer if you don't like the default one. Ex:"
	elog "\t echo \"export SCIPY_PIL_IMAGE_VIEWER=display\" >> ~/.bashrc"
}

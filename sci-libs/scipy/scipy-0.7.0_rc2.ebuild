# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/scipy/scipy-0.7.0_rc2.ebuild,v 1.1 2009/02/02 16:50:21 bicatali Exp $

EAPI=1
NEED_PYTHON=2.4
MYP=${P/_rc/rc}
inherit eutils distutils fortran flag-o-matic

SRC_URI="mirror://sourceforge/${PN}/${MYP}.tar.gz"
DESCRIPTION="Scientific algorithms library for Python"
HOMEPAGE="http://www.scipy.org/"
LICENSE="BSD"

SLOT="0"

IUSE="test umfpack"

KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"

CDEPEND=">=dev-python/numpy-1.2
	virtual/cblas
	virtual/lapack
	umfpack? ( sci-libs/umfpack )"

DEPEND="${CDEPEND}
	dev-util/pkgconfig
	test? ( dev-python/nose )
	umfpack? ( dev-lang/swig )"

RDEPEND="${CDEPEND}
	dev-python/imaging"

DOCS="THANKS.txt LATEST.txt TOCHANGE.txt"

S="${WORKDIR}/${MYP}"

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
	if use umfpack && ! built_with_use dev-lang/swig python; then
		eerror "With umfpack enabled you need"
		eerror "dev-lang/swig with python enabled"
		einfo  "Please re-emerge swig with USE=python"
		die "needs swig with python"
	fi
	# scipy automatically detects libraries by default
	export {FFTW,FFTW3,UMFPACK}=None
	use umfpack && unset UMFPACK
	scipy_fortran_setup
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-0.7.0_beta1-implicit.patch
	epatch "${FILESDIR}"/${PN}-0.6.0-stsci.patch
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
}

src_compile() {
	# when fortran flags are set, pic is removed.
	use amd64 && [[ -n ${FFLAGS} ]] && FFLAGS="${FFLAGS} -fPIC"
	distutils_src_compile ${SCIPY_FCONFIG}
}

src_test() {
	"${python}" setup.py install \
		--home="${S}"/test \
		--no-compile \
		${SCIPY_FCONFIG} || die "install test failed"
	pushd "${S}"/test/lib*/python
	PYTHONPATH=. "${python}" -c "import scipy; scipy.test('full')" 2>&1 | tee test.log
	grep -q ^ERROR test.log && die "test failed"
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

# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/numpy/numpy-1.0.3.1.ebuild,v 1.1 2007/08/24 13:31:23 bicatali Exp $

NEED_PYTHON=2.3

inherit distutils eutils

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
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
LICENSE="BSD"

S="${WORKDIR}/${MY_P}"

# whatever LDFLAGS set will break linking
# as reported in many tickets in http://projects.scipy.org/scipy/numpy
LDFLAGS_sav="${LDFLAGS}"
unset LDFLAGS
pkg_setup() {
	[[ -n "${LDFLAGS_sav}" ]] && einfo "Ignoring LDFLAGS=${LDFLAGS_sav}"
}

numpy_lapack_setup() {
	local mycblas
	for d in $(eselect cblas show); do mycblas=${d}; done
	if [[ -z "${mycblas/reference/}" ]] && [[ -z "${mycblas/atlas/}" ]]; then
		ewarn "You need to set cblas to atlas or reference. Do:"
		ewarn "   eselect cblas set <impl>"
		ewarn "where <impl> is atlas, threaded-atlas or reference"
		die "numpy_lapack_setup failed"
	fi

	# Remove default values
	echo "[blas_opt]"  > site.cfg
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
			eerror "Invalid cblas implementation: ${cblas}"
			die "numpy_lapack_setup failed"
			;;
	esac
	echo "[lapack_opt]"  >> site.cfg
	echo "libraries = lapack" >> site.cfg
	unset LAPACK
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	# Fix some paths and docs in f2py
	epatch "${FILESDIR}"/${PN}-1.0.1-f2py.patch
	# Gentoo patch for ATLAS library names
	sed -i \
		-e "s:'f77blas':'blas':g" \
		-e "s:'ptblas':'blas':g" \
		-e "s:'ptcblas':'cblas':g" \
		-e "s:'lapack_atlas':'lapack':g" \
		numpy/distutils/system_info.py \
		|| die "sed system_info.py failed"

	export BLAS=None
	export LAPACK=None
	export ATLAS=None
	export PTATLAS=None
	export MKL=None
	use lapack && numpy_lapack_setup
}

src_test() {
	"${python}" setup.py install \
		--home="${S}"/test \
		--no-compile \
		|| die "install test failed"

	pushd "${S}"/test/lib*/python
	PYTHONPATH=. "${python}" -c "import numpy; numpy.test(10,3)" 2>&1 \
		| tee test.log
	grep -q '^OK$' test.log || die "test failed"
	popd

_	rm -rf test
}


src_install() {
	distutils_src_install

	docinto numpy
	dodoc numpy/doc/*txt || die "dodoc failed"

	docinto f2py
	dodoc numpy/f2py/docs/*txt || die "dodoc f2py failed"
	doman numpy/f2py/f2py.1 || die "doman failed"
}

pkg_postinst() {
	if ! built_with_use sys-devel/gcc fortran && ! has_version dev-lang/ifc; then
		ewarn "To use numpy's f2py you need a fortran compiler."
		ewarn "You can either set USE=fortran flag and re-emerge gcc,"
		ewarn "or emerge dev-lang/ifc"
	fi
}

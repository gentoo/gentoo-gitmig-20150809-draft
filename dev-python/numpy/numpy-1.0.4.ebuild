# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/numpy/numpy-1.0.4.ebuild,v 1.2 2007/11/21 01:31:17 lavajoe Exp $

NEED_PYTHON=2.3

inherit distutils eutils

MY_P=${P/_beta/b}
MY_P=${MY_P/_}

DESCRIPTION="Python array processing for numbers, strings, records, and objects"
SRC_URI="mirror://sourceforge/numpy/${MY_P}.tar.gz"
HOMEPAGE="http://numeric.scipy.org/"

RDEPEND="!dev-python/f2py
	lapack? ( virtual/cblas virtual/lapack )"
DEPEND="${RDEPEND}
	lapack? ( dev-util/pkgconfig )"

IUSE="lapack"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
LICENSE="BSD"

S="${WORKDIR}/${MY_P}"

# whatever LDFLAGS set will break linking
# as reported in many tickets in http://projects.scipy.org/scipy/numpy
LDFLAGS_sav="${LDFLAGS}"
unset LDFLAGS
pkg_setup() {
	[[ -n "${LDFLAGS_sav}" ]] && einfo "Ignoring LDFLAGS=${LDFLAGS_sav}"
}

# ex usage: pkgconf_cfg --libs-only-l cblas: ['cblas','atlas']
pkgconf_cfg() {
	local cfg="["
	for i in $(pkg-config "$1" "$2"); do
		cfg="${cfg}'${i:2}'"
	done
	echo "${cfg//\'\'/','}]"
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Fix some paths and docs in f2py
	epatch "${FILESDIR}"/${PN}-1.0.1-f2py.patch

	# Patch to use feclearexcept(3) rather than fpsetsticky(3) on FreeBSD 5.3+
	epatch "${FILESDIR}"/${P}-freebsd.patch

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

	if use lapack; then
		unset BLAS LAPACK
		cat > setup.cfg << EOF
[blas_opt]
libraries = $(pkgconf_cfg --libs-only-l cblas)
library_dirs = $(pkgconf_cfg --libs-only-L cblas)

[lapack_opt]
libraries = $(pkgconf_cfg --libs-only-l lapack)
library_dirs = $(pkgconf_cfg --libs-only-L lapack)
EOF
	fi
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

	rm -rf test
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

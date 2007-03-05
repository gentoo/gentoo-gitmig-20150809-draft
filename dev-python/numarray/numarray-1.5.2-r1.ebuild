# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/numarray/numarray-1.5.2-r1.ebuild,v 1.2 2007/03/05 02:47:44 genone Exp $

NEED_PYTHON=2.3

inherit distutils fortran

DOC_PV=1.5
DESCRIPTION="Large array processing extension module for Python"
SRC_URI="mirror://sourceforge/numpy/${P}.tar.gz
	doc? ( mirror://sourceforge/numpy/${PN}-${DOC_PV}.html.tar.gz )"
HOMEPAGE="http://www.stsci.edu/resources/software_hardware/numarray"

# numarray does not work yet with other cblas implementations
# than cblas-reference or blas-atlas
RDEPEND="lapack? ( || ( >=sci-libs/blas-atlas-3.7.11-r1
				   >=sci-libs/cblas-reference-20030223-r3 )
				   virtual/lapack )"
DEPEND="${RDEPEND}
	lapack? ( app-admin/eselect-cblas )"

IUSE="doc lapack"
SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="BSD"

DOCS="LICENSE.txt Doc/*.txt Doc/release_notes/ANNOUNCE-${PV:0:3}"

pkg_setup() {
	if use lapack; then
		FORTRAN="gfortran g77"
		fortran_pkg_setup
		for d in $(eselect cblas show); do mycblas=${d}; done
		if [[ -z "${mycblas/reference/}" ]] && [[ -z "${mycblas/atlas/}" ]]; then
			ewarn "You need to set cblas to atlas or reference. Do:"
			ewarn "   eselect cblas set <impl>"
			ewarn "where <impl> is atlas, threaded-atlas or reference"
			die "setup failed"
		fi
	fi
}

src_unpack() {
	if use lapack; then
		fortran_src_unpack
	else
		unpack ${A}
	fi

	cd "${S}"
	# include Python.h from header files using the PyObject_HEAD macro.
	epatch "${FILESDIR}"/${P}-includes.patch

	# fix refcount problem from a debian bug
	epatch "${FILESDIR}"/${P}-refcount.patch

	# fix hard-coded path in numinclude
	sed -i \
		-e "s:/home/jmiller/work/debug/include/python2.5:/usr/include/python${PYVER}:" \
		Lib/numinclude.py || die "sed failed"

	# configure cfg_packages.py for lapack
	if use lapack; then
		sed -i \
			-e '/^if USE_LAPACK:/iUSE_LAPACK=True' \
			-e 's:/usr/local/include/atlas:/usr/include/atlas:g' \
			-e "s:/usr/local/lib/atlas:/usr/$(get_libdir):g" \
			-e 's:f77blas:blas:g' \
			cfg_packages.py
		# fix gfortran for > gcc-4
		if  [[ "${FORTRANC}" == gfortran ]]; then
			sed -i \
				-e "s:g2c:gfortran:g" \
				cfg_packages.py
		fi
		[[ "${mycblas}" == reference ]] && \
			sed -i \
			-e "s:'atlas',::g" \
			-e "s:include/atlas:include/cblas:g" \
			cfg_packages.py
	fi
	${python} setup.py config --gencode || die "API code generation failed"
}

src_test() {
	# test with lapack buggy
	if use lapack; then
		elog "no automatic testing with external lapack"
		return
	fi
	ebegin "Testing numarray functions"
	cd build/lib*
	cp "${S}"/Lib/testdata.fits numarray
	PYTHONPATH=. "${python}" -c \
		"from numarray.testall import test;import sys;sys.exit(test())" \
		> test.log
	grep -q -i failed test.log  && die "failed tests in ${PWD}/test.log"
	eend $?
	rm -f numarray/testdata.fits test*.*
}


src_install() {
	distutils_src_install
	if use doc; then
		insinto /usr/share/doc/${PF}
		doins -r Examples
		dohtml ${WORKDIR}/${PN}-${DOC_PV}/* || die "dohtml failed"
	fi
}

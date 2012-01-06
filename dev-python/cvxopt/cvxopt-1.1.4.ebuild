# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cvxopt/cvxopt-1.1.4.ebuild,v 1.1 2012/01/06 15:40:31 bicatali Exp $

EAPI=4

SUPPORT_PYTHON_ABIS=1
RESTRICT_PYTHON_ABIS="2.4"

inherit distutils eutils

DESCRIPTION="Python package for convex optimization"
HOMEPAGE="http://abel.ee.ucla.edu/cvxopt"
SRC_URI="http://abel.ee.ucla.edu/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc +dsdp examples fftw +glpk gsl"

RDEPEND="virtual/blas
	virtual/cblas
	virtual/lapack
	sci-libs/cholmod
	sci-libs/umfpack
	dsdp? ( sci-libs/dsdp )
	fftw? ( sci-libs/fftw:3.0 )
	glpk? ( sci-mathematics/glpk )
	gsl? ( sci-libs/gsl )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( dev-python/sphinx )"

S="${WORKDIR}/${P}/src"

src_prepare(){
	epatch "${FILESDIR}"/${PN}-setup.patch
	rm -rf src/C/SuiteSparse*/

	pkg_lib() {
		local pylib=\'$(pkg-config --libs-only-l ${1} | sed \
			-e 's/^-l//' \
			-e "s/ -l/\',\'/g" \
			-e 's/.,.pthread//g' \
			-e "s:  ::")\'
		sed -i -e "s:\(libraries.*\)'${1}'\(.*\):\1${pylib}\2:g" setup.py
	}

	use_cvx() {
		if use ${1}; then
			sed -i \
				-e "s/\(BUILD_${2^^} =\) 0/\1 1/" \
				setup.py || die
		fi
	}

	pkg_lib blas
	pkg_lib cblas
	pkg_lib lapack
	use_cvx gsl && pkg_lib gsl
	use_cvx fftw && pkg_lib fftw3
	use_cvx glpk
	use_cvx dsdp
	distutils_src_prepare
}

src_compile() {
	distutils_src_compile
	use doc && emake -C "${WORKDIR}"/doc -B "${WORKDIR}"/html
}

src_test() {
	cd "${WORKDIR}"/${P}/examples/doc/chap8
	testing() {
		PYTHONPATH="$(ls -d ${S}/build-${PYTHON_ABI}/lib.*)" "$(PYTHON)" lp.py
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install
	use doc && dohtml -r "${WORKDIR}"/${P}/html
	insinto /usr/share/doc/${PF}
	use examples && doins -r "${WORKDIR}"/${P}/examples
}

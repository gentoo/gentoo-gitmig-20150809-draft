# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/numexpr/numexpr-1.4.1.ebuild,v 1.1 2010/10/24 08:48:29 xarthisius Exp $

EAPI=2

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Fast numerical array expression evaluator for Python and NumPy."
HOMEPAGE="http://code.google.com/p/numexpr/ http://pypi.python.org/pypi/numexpr"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="mkl"

RDEPEND=">=dev-python/numpy-1.3.1
	mkl? ( sci-libs/mkl )"
DEPEND="${RDEPEND}
	>=dev-python/setuptools-0.6_rc3
	>=dev-util/scons-1.2.0-r1"

RESTRICT_PYTHON_ABIS="3.*"

src_prepare() {
	# TODO: alternatively icc's mkl can be used but it fails for me
	if use mkl; then
		cat <<- EOF > "${S}"/site.cfg
		[mkl]
		library_dirs = ${MKLROOT}/lib/em64t
		include_dirs = ${MKLROOT}/include
		mkl_libs = mkl_solver_ilp64, mkl_intel_ilp64, \
		mkl_intel_thread, mkl_core, iomp5
		EOF
	fi
}

src_test() {
	testing() {
		PYTHONPATH="$(ls -d build-${PYTHON_ABI}/lib.*)" "$(PYTHON)" ${PN}/tests/test_${PN}.py
	}
	python_execute_function testing
}

# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pycuda/pycuda-2011.2.2.ebuild,v 1.3 2012/02/20 14:26:27 patrick Exp $

EAPI=4

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython 2.7-pypy-**"

inherit distutils multilib

DESCRIPTION="Python wrapper for NVIDIA CUDA"
HOMEPAGE="http://mathema.tician.de/software/pycuda/ http://pypi.python.org/pypi/pycuda/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples opengl"

RDEPEND="
	<dev-libs/boost-1.48[python]
	dev-python/decorator
	dev-python/numpy
	dev-python/pytools
	dev-util/nvidia-cuda-toolkit
	opengl? ( virtual/opengl )"
DEPEND="${RDEPEND}"

src_configure() {
	local myopts=""
	use opengl && myopts="${myopts} --cuda-enable-gl"

	./configure.py \
		--cuda-root="${ROOT}opt/cuda" \
		--boost-lib-dir="${EPREFIX}/usr/$(get_libdir)" \
		--boost-inc-dir="${EPREFIX}/usr/include" \
		--cudadrv-lib-dir="${EPREFIX}/usr/$(get_libdir)" \
		--cudart-lib-dir="${EPREFIX}/opt/cuda/$(get_libdir)" \
		--boost-python-libname=boost_python-mt \
		--boost-thread-libname=boost_thread-mt \
		--no-use-shipped-boost \
		${myopts}
}

src_install() {
	distutils_src_install
	insinto /usr/share/doc/${PF}
	if use examples; then
		doins -r examples || die
	fi
}

# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pycuda/pycuda-9999.ebuild,v 1.8 2011/09/21 08:48:19 mgorny Exp $

EAPI="3"
PYTHON_DEPEND="2"

inherit git-2 distutils

EGIT_REPO_URI="http://git.tiker.net/trees/pycuda.git"

DESCRIPTION="Python wrapper for NVIDIA CUDA"
HOMEPAGE="http://mathema.tician.de/software/pycuda http://pypi.python.org/pypi/pycuda"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="examples opengl"

RDEPEND="=dev-python/pytools-9999
	dev-libs/boost[python]
	>=dev-util/nvidia-cuda-toolkit-2.0
	>=dev-python/numpy-1.0.4
	virtual/opengl"

DEPEND="${RDEPEND}"

src_unpack() {
	git-2_src_unpack
}

src_configure() {
	local myopts=""
	use opengl && myopts="${myopts} --cuda-enable-gl"
	./configure.py --cuda-root="${ROOT}opt/cuda" \
			--boost-python-libname=boost_python-mt \
			--boost-thread-libname=boost_thread-mt --boost-compiler=gcc ${myopts}
}

src_install() {
	distutils_src_install
	insinto /usr/share/doc/${PF}
	if use examples; then
		doins -r examples || die
	fi
}

pkg_postinst() {
	distutils_pkg_postinst
	if use examples; then
		elog "Some of the examples provided by this package require dev-python/matplotlib."
	fi
}

# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pycuda/pycuda-0.94.2.ebuild,v 1.3 2011/01/01 21:15:03 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"

inherit distutils eutils

DESCRIPTION="Python wrapper for NVIDIA CUDA"
HOMEPAGE="http://mathema.tician.de/software/pycuda http://pypi.python.org/pypi/pycuda"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples opengl"

RDEPEND="dev-python/decorator
	dev-python/pytools
	dev-libs/boost[python]
	>=dev-util/nvidia-cuda-toolkit-2.0
	>=dev-python/numpy-1.0.4
	virtual/opengl"
DEPEND="${RDEPEND}"

src_configure()
{
	local myopts=""
	use opengl && myopts="${myopts} --cuda-enable-gl"

	./configure.py --cuda-root="${ROOT}opt/cuda" \
		--boost-python-libname=boost_python-mt \
		--boost-thread-libname=boost_thread-mt \
		${myopts}
}

src_install()
{
	distutils_src_install
	insinto /usr/share/doc/${PF}
	if use examples; then
		doins -r examples || die
	fi
}

pkg_postinst()
{
	distutils_pkg_postinst
	if use examples; then
		elog "Some of the examples provided by this package require dev-python/matplotlib."
	fi
}

# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pycuda/pycuda-0.92.ebuild,v 1.1 2009/06/06 15:44:44 spock Exp $

EAPI="2"

inherit distutils

DESCRIPTION="Python wrapper for NVIDIA CUDA"
HOMEPAGE="http://mathema.tician.de/software/pycuda"
SRC_URI="http://pypi.python.org/packages/source/p/pycuda/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

RDEPEND="dev-python/pytools
	dev-libs/boost[python]
	>=dev-util/nvidia-cuda-toolkit-2.0
	>=dev-python/numpy-1.0.4"
DEPEND="${RDEPEND}"

src_configure()
{
	./configure.py --cuda-root="${ROOT}opt/cuda" --boost-python-libname=boost_python-mt
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

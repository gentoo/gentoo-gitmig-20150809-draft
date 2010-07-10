# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/PyAmanith/PyAmanith-0.3.34.ebuild,v 1.4 2010/07/10 20:22:27 arfrever Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"

inherit distutils eutils

DESCRIPTION="Python wrapper for the Amanith 2D vector graphics library"
HOMEPAGE="http://louhi.kempele.fi/~skyostil/projects/pyamanith/"
SRC_URI="http://louhi.kempele.fi/~skyostil/projects/pyamanith/dist/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=media-libs/amanith-0.3"
DEPEND="${RDEPEND}
	>=dev-lang/swig-1.3.29"

PYTHON_CXXFLAGS=("2.* + -fno-strict-aliasing")

PYTHON_MODNAME="amanith.py"

src_prepare() {
	distutils_src_prepare

	# perhaps someone with more swig/distutils clout can make this
	# package stop sucking so hard
	sed -i \
		-e '/include/s:build/amanith/include/::' \
		headers.i
	epatch "${FILESDIR}/${P}-build.patch"
}

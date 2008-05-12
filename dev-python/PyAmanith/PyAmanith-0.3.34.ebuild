# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/PyAmanith/PyAmanith-0.3.34.ebuild,v 1.3 2008/05/12 07:25:10 hawking Exp $

NEED_PYTHON=2.3

inherit eutils distutils

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

src_unpack() {
	distutils_src_unpack

	# perhaps someone with more swig/distutils clout can make this
	# package stop sucking so hard
	sed -i \
		-e '/include/s:build/amanith/include/::' \
		headers.i
	epatch "${FILESDIR}"/${P}-build.patch
}

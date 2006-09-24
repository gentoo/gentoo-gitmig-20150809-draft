# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/PyAmanith/PyAmanith-0.3.34.ebuild,v 1.1 2006/09/24 10:19:41 vapier Exp $

inherit eutils distutils

DESCRIPTION="Python wrapper for the Amanith 2D vector graphics library"
HOMEPAGE="http://louhi.kempele.fi/~skyostil/projects/pyamanith/"
SRC_URI="http://louhi.kempele.fi/~skyostil/projects/pyamanith/dist/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.3
	>=media-libs/amanith-0.3
	>=dev-lang/swig-1.3.25"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# perhaps someone with more swig/distutils clout can make this
	# package stop sucking so hard
	sed -i \
		-e '/include/s:build/amanith/include/::' \
		headers.i
	epatch "${FILESDIR}"/${P}-build.patch
}

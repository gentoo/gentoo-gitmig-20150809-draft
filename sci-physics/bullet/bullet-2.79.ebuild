# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-physics/bullet/bullet-2.79.ebuild,v 1.1 2011/11/28 22:25:42 bicatali Exp $

EAPI=4

inherit eutils cmake-utils

DESCRIPTION="Continuous Collision Detection and Physics Library"
HOMEPAGE="http://www.bulletphysics.com/"
SRC_URI="http://bullet.googlecode.com/files/${P}-rev2440.tgz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux"
IUSE="doc double-precision examples extras"

RDEPEND="virtual/opengl"
DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}"/${PN}-2.78-soversion.patch )

src_configure() {
	mycmakeargs=(
		-DBUILD_SHARED_LIBS=ON
		-DBUILD_CPU_DEMOS=OFF
		-DBUILD_DEMOS=OFF
		-DUSE_GRAPHICAL_BENCHMARK=OFF
		-DINSTALL_LIBS=ON
		-DINSTALL_EXTRA_LIBS=ON
		$(cmake-utils_use_build extras EXTRAS)
		$(cmake-utils_use_use double-precision DOUBLE_PRECISION)
	)
	cmake-utils_src_configure
}

src_install() {
	default
	use doc && dodoc *.pdf
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r Extras Demos
	fi
}

# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/avogadro/avogadro-1.0.0.ebuild,v 1.2 2010/02/25 14:59:39 lxnay Exp $

EAPI=2

inherit cmake-utils eutils

DESCRIPTION="Advanced molecular editor that uses Qt4 and OpenGL"
HOMEPAGE="http://avogadro.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+glsl python"

RDEPEND=">=sci-chemistry/openbabel-2.2.2
	>=x11-libs/qt-gui-4.5.2:4
	>=x11-libs/qt-opengl-4.5.2:4
	glsl? ( >=media-libs/glew-1.5.0	)
	python? (
		>=dev-lang/python-2.5
		>=dev-libs/boost-1.35
		>=dev-libs/boost-1.35.0-r5[python]
		dev-python/numpy
		dev-python/sip
	)"
DEPEND="${RDEPEND}
	dev-cpp/eigen:2
	>=dev-util/cmake-2.6.2"

src_prepare() {
	epatch "${FILESDIR}/${P}-sip-4.10.patch"
}

src_configure() {
	local mycmakeargs
	mycmakeargs="${mycmakeargs}
		-DENABLE_THREADGL=FALSE
		-DENABLE_RPATH=OFF
		-DENABLE_UPDATE_CHECKER=OFF
		$(cmake-utils_use_enable glsl GLSL)
		$(cmake-utils_use_enable python PYTHON)"

	cmake-utils_src_configure
}

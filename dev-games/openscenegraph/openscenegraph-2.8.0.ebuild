# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/openscenegraph/openscenegraph-2.8.0.ebuild,v 1.6 2009/03/08 20:08:59 tupone Exp $

EAPI=2
inherit eutils versionator cmake-utils

MY_PN="OpenSceneGraph"
MY_P=${MY_PN}-${PV}
MY_P_MAJOR=${MY_PN}-$(get_version_component_range 1-2)

DESCRIPTION="Open source high performance 3D graphics toolkit"
HOMEPAGE="http://www.openscenegraph.org/projects/osg/"
SRC_URI="http://www.openscenegraph.org/downloads/stable_releases/${MY_P_MAJOR}/source/${MY_P}.zip"

LICENSE="wxWinLL-3 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE="osgapps pdf xulrunner"

RDEPEND="virtual/opengl
	virtual/glu
	net-misc/curl
	xulrunner? ( net-libs/xulrunner )
	gnome-base/librsvg
	media-libs/jpeg
	media-libs/giflib
	media-libs/tiff
	media-libs/jasper
	media-libs/xine-lib
	pdf? (
		|| (
			app-text/poppler-bindings[gtk]
			app-text/poppler-bindings[cairo]
		)
	)"
DEPEND="${RDEPEND}
	app-arch/unzip"

S="${WORKDIR}"/${MY_P}

DOCS="AUTHORS.txt ChangeLog NEWS.txt"

src_prepare() {
	epatch "${FILESDIR}"/${P}-magicoff.patch
}

src_configure() {
	mycmakeargs=""
	if ! use osgapps; then
		mycmakeargs="${mycmakeargs} -DBUILD_OSG_APPLICATIONS=OFF"
	fi
	mycmakeargs="${mycmakeargs} $(cmake-utils_use_enable xulrunner XUL)"
	mycmakeargs="${mycmakeargs} $(cmake-utils_use_enable pdf PDF)"
	cmake-utils_src_configure
}

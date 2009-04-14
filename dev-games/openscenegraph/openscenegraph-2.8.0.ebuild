# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/openscenegraph/openscenegraph-2.8.0.ebuild,v 1.12 2009/04/14 17:37:21 nyhm Exp $

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
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="curl gif jpeg jpeg2k osgapps pdf png svg tiff truetype xine xrandr xulrunner"

RDEPEND="virtual/opengl
	virtual/glu
	png? ( media-libs/libpng )
	jpeg? ( media-libs/jpeg )
	gif? ( media-libs/giflib )
	tiff? ( media-libs/tiff )
	truetype? ( media-libs/freetype:2 )
	x11-libs/libSM
	x11-libs/libXext
	xrandr? ( x11-libs/libXrandr )
	curl? ( net-misc/curl )
	xulrunner? ( net-libs/xulrunner )
	svg? ( gnome-base/librsvg )
	jpeg2k? ( media-libs/jasper )
	xine? ( media-libs/xine-lib )
	pdf? ( virtual/poppler-glib[cairo] )
	"
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
	mycmakeargs="${mycmakeargs} $(cmake-utils_use_enable xine XINE)"
	mycmakeargs="${mycmakeargs} $(cmake-utils_use_enable jpeg2k JPEG2K)"
	mycmakeargs="${mycmakeargs} $(cmake-utils_use_enable svg SVG)"
	mycmakeargs="${mycmakeargs} $(cmake-utils_use_enable truetype FREETYPE)"
	mycmakeargs="${mycmakeargs} $(cmake-utils_use_enable curl CURL)"
	mycmakeargs="${mycmakeargs} $(cmake-utils_use_enable gif GIF)"
	mycmakeargs="${mycmakeargs} $(cmake-utils_use_enable png PNG)"
	mycmakeargs="${mycmakeargs} $(cmake-utils_use_enable jpeg JPEG)"
	mycmakeargs="${mycmakeargs} $(cmake-utils_use_enable tiff TIFF)"
	mycmakeargs="${mycmakeargs} $(cmake-utils_use_enable xrandr XRANDR)"
	cmake-utils_src_configure
}

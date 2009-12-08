# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/openscenegraph/openscenegraph-2.8.2.ebuild,v 1.3 2009/12/08 20:18:35 mr_bones_ Exp $

EAPI=2
inherit eutils versionator base cmake-utils

MY_PN="OpenSceneGraph"
MY_P=${MY_PN}-${PV}

DESCRIPTION="Open source high performance 3D graphics toolkit"
HOMEPAGE="http://www.openscenegraph.org/projects/osg/"
SRC_URI="http://www.openscenegraph.org/downloads/stable_releases/${MY_P}/source/${MY_P}.zip"

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
	xulrunner? ( net-libs/xulrunner:1.8 )
	svg? ( gnome-base/librsvg )
	jpeg2k? ( media-libs/jasper )
	xine? ( media-libs/xine-lib )
	pdf? ( virtual/poppler-glib[cairo] )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	app-arch/unzip"

S=${WORKDIR}/${MY_P}

DOCS="AUTHORS.txt ChangeLog NEWS.txt"

PATCHES=(
	"${FILESDIR}"/${P}-magicoff.patch
)

src_configure() {
	mycmakeargs="
		$(cmake-utils_use_build osgapps OSG_APPLICATIONS)
		$(cmake-utils_use_enable xulrunner XUL)
		$(cmake-utils_use_enable pdf)
		$(cmake-utils_use_enable xine)
		$(cmake-utils_use_enable jpeg2k JPEG2K)
		$(cmake-utils_use_enable svg)
		$(cmake-utils_use_enable truetype FREETYPE)
		$(cmake-utils_use_enable curl)
		$(cmake-utils_use_enable gif)
		$(cmake-utils_use_enable png)
		$(cmake-utils_use_enable jpeg)
		$(cmake-utils_use_enable tiff)
		$(cmake-utils_use_enable xrandr)
	"
	cmake-utils_src_configure
}

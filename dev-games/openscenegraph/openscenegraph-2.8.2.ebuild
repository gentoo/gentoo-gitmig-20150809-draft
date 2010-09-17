# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/openscenegraph/openscenegraph-2.8.2.ebuild,v 1.12 2010/09/17 11:07:44 scarabeus Exp $

EAPI=2
inherit eutils versionator base cmake-utils

MY_PN="OpenSceneGraph"
MY_P=${MY_PN}-${PV}

DESCRIPTION="Open source high performance 3D graphics toolkit"
HOMEPAGE="http://www.openscenegraph.org/projects/osg/"
SRC_URI="http://www.openscenegraph.org/downloads/stable_releases/${MY_P}/source/${MY_P}.zip"

LICENSE="wxWinLL-3 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE="curl gif jpeg jpeg2k osgapps pdf png svg tiff truetype xine xrandr"

RDEPEND="virtual/opengl
	png? ( media-libs/libpng )
	jpeg? ( media-libs/jpeg )
	gif? ( media-libs/giflib )
	tiff? ( media-libs/tiff )
	truetype? ( media-libs/freetype:2 )
	x11-libs/libSM
	x11-libs/libXext
	xrandr? ( x11-libs/libXrandr )
	curl? ( net-misc/curl )
	svg? ( gnome-base/librsvg )
	jpeg2k? ( media-libs/jasper )
	xine? ( media-libs/xine-lib )
	pdf? ( >=app-text/poppler-0.12.3-r3[cairo] )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	app-arch/unzip"

S=${WORKDIR}/${MY_P}

DOCS="AUTHORS.txt ChangeLog NEWS.txt"

PATCHES=(
	"${FILESDIR}"/${P}-magicoff.patch
	"${FILESDIR}"/${P}-libpng14.patch
)

src_configure() {
	mycmakeargs="
		$(cmake-utils_use_build osgapps OSG_APPLICATIONS)
		-DENABLE_XUL=OFF
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

pkg_postinst() {
	if has_version 'dev-games/simgear'; then
		ewarn "dev-games/simgear has been detected and may need to be rebuilt now."
		ewarn "Please run the following:"
		ewarn "  # emerge -1 dev-games/simgear"
	fi
}

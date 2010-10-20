# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/krita/krita-2.1.2.ebuild,v 1.6 2010/10/20 20:34:50 dilfridge Exp $

EAPI="2"

KMNAME="koffice"
KMMODULE="${PN}"
OPENGL_REQUIRED="optional"
inherit kde4-meta

DESCRIPTION="KOffice image manipulation program."

KEYWORDS="~ppc ~ppc64"
IUSE="gmm +kdcraw openexr +pdf +tiff"

DEPEND="
	>=app-office/koffice-libs-${PV}:${SLOT}[openexr=]
	>=dev-cpp/eigen-2.0.3:2
	>=media-libs/qimageblitz-0.0.4
	>=media-gfx/exiv2-0.16
	>=media-gfx/imagemagick-0.6.4.9.2[openexr=,png,tiff?]
	gmm? ( sci-mathematics/gmm )
	kdcraw? ( >=kde-base/libkdcraw-${KDE_MINIMAL} )
	opengl? ( media-libs/glew )
	pdf? ( >=app-text/poppler-0.12.3-r3[qt4] )
"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="libs/"

KMLOADLIBS="koffice-libs"

PATCHES=( "${FILESDIR}/${PN}-2.1.0-opengl.patch"
	"${FILESDIR}/${PN}-2.1.1-libpng14.patch"
	"${FILESDIR}"/${P}-gcc45.patch )

src_configure() {
	mycmakeargs="${mycmakeargs}
		-DWITH_Eigen2=On
		-DWITH_Exiv2=On
		-DWITH_JPEG=On
		$(cmake-utils_use_with openexr OpenEXR)
		$(cmake-utils_use_with gmm)
		$(cmake-utils_use_with tiff)
		$(cmake-utils_use_with kdcraw)
		$(cmake-utils_use_with pdf Poppler)
		$(cmake-utils_use_with opengl OpenGL)
		$(cmake-utils_use_with opengl GLEW)"

	kde4-meta_src_configure
}

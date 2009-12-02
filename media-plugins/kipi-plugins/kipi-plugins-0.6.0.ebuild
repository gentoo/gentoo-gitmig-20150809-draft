# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/kipi-plugins/kipi-plugins-0.6.0.ebuild,v 1.4 2009/12/02 10:07:31 scarabeus Exp $

EAPI="2"

OPENGL_REQUIRED="optional"
KDE_LINGUAS="ar be ca cs da de el es et fi fr ga gl hi hne is it ja km lt lv ms nb nds nl
nn oc pa pl pt pt_BR ro ru se sk sv th tr uk zh_CN"
inherit kde4-base

MY_P="${P/_/-}"

DESCRIPTION="Plugins for the KDE Image Plugin Interface (libkipi)."
HOMEPAGE="http://www.kipi-plugins.org"
SRC_URI="mirror://sourceforge/kipi/${MY_P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="amd64 x86"
IUSE="cdr calendar debug +imagemagick ipod mjpeg scanner"
SLOT="4"

DEPEND="
	>=dev-libs/expat-2.0.1
	dev-libs/libxml2
	dev-libs/libxslt
	>=kde-base/libkdcraw-${KDE_MINIMAL}
	>=kde-base/libkexiv2-${KDE_MINIMAL}
	>=kde-base/libkipi-${KDE_MINIMAL}
	media-libs/jpeg
	media-libs/libpng
	>=media-libs/tiff-3.5
	calendar? ( >=kde-base/kdepimlibs-${KDE_MINIMAL} )
	ipod? ( media-libs/libgpod )
	opengl? ( virtual/opengl )
	scanner? (
		media-gfx/sane-backends
		>=kde-base/libksane-${KDE_MINIMAL}
	)
"
RDEPEND="${DEPEND}
	cdr? ( app-cdr/k3b )
	imagemagick? ( media-gfx/imagemagick )
	mjpeg? ( media-video/mjpegtools )
"

S="${WORKDIR}/${MY_P}"

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with calendar KdepimLibs)
		$(cmake-utils_use_with opengl OpenGL)
		$(cmake-utils_use_with scanner KSane)
		$(cmake-utils_use_with scanner Sane)
		$(cmake-utils_use_with ipod Gpod)
		$(cmake-utils_use_with ipod GLIB2)
		$(cmake-utils_use_with ipod GObject)
		-DWITH_OpenCV=OFF"

	kde4-base_src_configure
}

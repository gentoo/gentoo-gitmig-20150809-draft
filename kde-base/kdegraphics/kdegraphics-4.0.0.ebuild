# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdegraphics/kdegraphics-4.0.0.ebuild,v 1.1 2008/01/17 23:48:27 philantrop Exp $

EAPI="1"

inherit kde4-base

DESCRIPTION="KDE graphics module"
HOMEPAGE="http://www.kde.org/"

KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook chm jpeg djvu pdf tiff"  
LICENSE="GPL-2 LGPL-2"

#RESTRICT="test"

DEPEND="media-gfx/exiv2
	media-libs/libgphoto2
	x11-apps/xgamma
	x11-libs/libXxf86vm
	x11-proto/xf86vidmodeproto
	media-gfx/sane-backends
	media-libs/freetype
	virtual/ghostscript
	jpeg? ( media-libs/jpeg )
	chm? ( app-doc/chmlib )
	djvu? ( >=app-text/djvu-3.5.17 )
	pdf? ( >=app-text/poppler-0.5.4
		>=app-text/poppler-bindings-0.5.4 )
	tiff? ( media-libs/tiff )
	kde-base/qimageblitz"

pkg_setup() {
	if use pdf; then
		KDE4_BUILT_WITH_USE_CHECK="${KDE4_BUILT_WITH_USE_CHECK}
			app-text/poppler-bindings qt4"
	fi
	kde4-base_pkg_setup
}

src_compile() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with chm CHM)
		$(cmake-utils_use_with djvu DjVuLibre)
		$(cmake-utils_use_with jpeg JPEG)
		$(cmake-utils_use_with pdf PopplerQt4)
		$(cmake-utils_use_with pdf Poppler)
		$(cmake-utils_use_with tiff TIFF)"

	kde4-base_src_compile
}

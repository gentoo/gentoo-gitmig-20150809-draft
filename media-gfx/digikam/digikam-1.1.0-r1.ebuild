# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/digikam/digikam-1.1.0-r1.ebuild,v 1.3 2010/03/27 16:18:08 ssuominen Exp $

EAPI=2
KDE_LINGUAS="ar be bg ca ca@valencia cs da de el en_GB eo es et eu fa fi fr ga
gl he hi hne hr hu is it ja km ko lt lv nb nds ne nl nn pa pl pt pt_BR ro ru se
sk sl sv th tr uk vi zh_CN zh_TW"
inherit kde4-base

DESCRIPTION="A digital photo management application for KDE."
HOMEPAGE="http://www.digikam.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2
	mirror://gentoo/${P}-libjpeg-8a.patch.bz2"

LICENSE="GPL-2 LGPL-2.1 FDL-1.2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="addressbook debug doc geolocation +glib gphoto2 lensfun semantic-desktop +thumbnails"

RDEPEND=">=kde-base/kdelibs-${KDE_MINIMAL}[semantic-desktop?]
	>=kde-base/libkdcraw-${KDE_MINIMAL}
	>=kde-base/libkexiv2-${KDE_MINIMAL}
	>=kde-base/libkipi-${KDE_MINIMAL}
	>=kde-base/solid-${KDE_MINIMAL}
	media-libs/jasper
	>=media-libs/jpeg-8a:0
	media-libs/lcms
	media-libs/liblqr
	media-libs/libpng
	media-libs/tiff
	>=media-libs/libpgf-6.09.44-r1
	x11-libs/qt-sql:4[sqlite]
	glib? ( dev-libs/glib:2 )
	addressbook? ( >=kde-base/kdepimlibs-${KDE_MINIMAL} )
	geolocation? ( >=kde-base/marble-${KDE_MINIMAL} )
	gphoto2? ( >=media-libs/libgphoto2-2.4.1-r1 )
	lensfun? ( media-libs/lensfun )"
DEPEND="${RDEPEND}
	sys-devel/gettext
	doc? ( app-doc/doxygen )"

DOCS="AUTHORS ChangeLog DESIGN HACKING NEWS README TODO"

PATCHES=( "${FILESDIR}/${P}-libpgf.patch"
	"${WORKDIR}/${P}-libjpeg-8a.patch"
	"${FILESDIR}/${P}-libpng14.patch" )

src_configure() {
	mycmakeargs+=( "-DENABLE_THEMEDESIGNER=OFF"
		$(cmake-utils_use_enable thumbnails THUMBS_DB)
		$(cmake-utils_use_with glib GLIB2)
		$(cmake-utils_use_with gphoto2 Gphoto2)
		$(cmake-utils_use_with addressbook KdepimLibs)
		$(cmake-utils_use_with lensfun LensFun)
		"-DWITH_Lqr-1=ON"
		$(cmake-utils_use_with geolocation MarbleWidget)
		$(cmake-utils_use_with semantic-desktop Nepomuk)
		$(cmake-utils_use_with semantic-desktop Soprano)
		$(cmake-utils_use_build doc) )

	kde4-base_src_configure
}

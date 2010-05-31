# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/scribus/scribus-1.3.5.1.ebuild,v 1.9 2010/05/31 18:19:25 arfrever Exp $

EAPI=2
NEED_PYTHON=2.6
inherit cmake-utils fdo-mime multilib python

DESCRIPTION="Desktop publishing (DTP) and layout program"
HOMEPAGE="http://www.scribus.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~hppa ppc ppc64 ~sparc x86"
IUSE="cairo debug +pdf spell"

COMMON_DEPEND="dev-libs/hyphen
	dev-libs/libxml2
	media-libs/fontconfig
	>=media-libs/freetype-2
	media-libs/jpeg:0
	media-libs/lcms
	media-libs/libpng
	media-libs/tiff
	net-print/cups
	sys-libs/zlib
	x11-libs/qt-gui:4
	spell? ( app-text/aspell )
	pdf? ( app-text/podofo )
	cairo? ( x11-libs/cairo[X,svg] )"
RDEPEND="${COMMON_DEPEND}
	app-text/ghostscript-gpl"
DEPEND="${COMMON_DEPEND}
	dev-libs/boost"

PATCHES=( "${FILESDIR}/${P}-check-hdict.patch"
	"${FILESDIR}/${P}-system-hyphen.patch"
	"${FILESDIR}/${P}-lib2geom.patch" )

DOCS="AUTHORS ChangeLog* LINKS NEWS README TODO TRANSLATION"

src_configure() {
	mycmakeargs="${mycmakeargs}
		-DHAVE_PYTHON=ON
		-DPYTHON_INCLUDE_PATH=$(python_get_includedir)
		-DPYTHON_LIBRARY=$(python_get_library)
		-DWANT_NORPATH=ON
		-DWANT_QTARTHUR=ON
		-DWANT_QT3SUPPORT=OFF
		$(cmake-utils_use_has spell ASPELL)
		$(cmake-utils_use_has pdf PODOFO)
		$(cmake-utils_use_want cairo)"

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	doicon scribus/icons/scribus.png
	domenu scribus.desktop
}

pkg_postinst() {
	fdo-mime_mime_database_update
}

pkg_postrm() {
	fdo-mime_mime_database_update
}

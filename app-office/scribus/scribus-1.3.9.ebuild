# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/scribus/scribus-1.3.9.ebuild,v 1.2 2011/04/09 21:24:56 angelos Exp $

EAPI=2
PYTHON_DEPEND="2:2.6"

inherit cmake-utils fdo-mime multilib python

DESCRIPTION="Desktop publishing (DTP) and layout program"
HOMEPAGE="http://www.scribus.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE="cairo debug +minimal +pdf spell"

COMMON_DEPEND="
	dev-libs/hyphen
	dev-libs/libxml2
	media-libs/fontconfig
	>=media-libs/freetype-2
	virtual/jpeg
	=media-libs/lcms-1*
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

PATCHES=(
	"${FILESDIR}/${PN}-1.3.5.1-system-hyphen.patch"
	)

DOCS="AUTHORS ChangeLog* LINKS NEWS README TODO TRANSLATION"

pkg_setup() {
	python_set_active_version 2
}

src_configure() {
	mycmakeargs=(
		"-DHAVE_PYTHON=ON"
		"-DPYTHON_INCLUDE_PATH=$(python_get_includedir)"
		"-DPYTHON_LIBRARY=$(python_get_library)"
		"-DWANT_NORPATH=ON"
		"-DWANT_QTARTHUR=ON"
		"-DWANT_QT3SUPPORT=OFF"
		$(cmake-utils_use_has spell ASPELL)
		$(cmake-utils_use_has pdf PODOFO)
		$(cmake-utils_use_want cairo)
		$(cmake-utils_use_want minimal NOHEADERINSTALL)
		)

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	doicon resources/icons/scribus.png
	domenu scribus.desktop
}

pkg_postinst() {
	fdo-mime_mime_database_update
}

pkg_postrm() {
	fdo-mime_mime_database_update
}

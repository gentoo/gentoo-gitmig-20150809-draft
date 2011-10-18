# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/scribus/scribus-1.4.0_rc6.ebuild,v 1.1 2011/10/18 10:51:25 jlec Exp $

EAPI=3

PYTHON_DEPEND="2:2.6"

inherit cmake-utils fdo-mime multilib python

MY_P="${P/_/.}"

DESCRIPTION="Desktop publishing (DTP) and layout program"
HOMEPAGE="http://www.scribus.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE="cairo debug examples +minimal +pdf spell templates"

COMMON_DEPEND="
	dev-libs/hyphen
	dev-libs/libxml2
	media-libs/fontconfig
	media-libs/freetype:2
	media-libs/lcms:2
	media-libs/libpng
	media-libs/tiff
	net-print/cups
	sys-libs/zlib
	x11-libs/qt-core:4
	x11-libs/qt-gui:4
	virtual/jpeg
	spell? ( app-text/aspell )
	pdf? ( app-text/podofo )
	cairo? ( x11-libs/cairo[X,svg] )"
RDEPEND="${COMMON_DEPEND}
	app-text/ghostscript-gpl"
DEPEND="${COMMON_DEPEND}
	dev-libs/boost"

PATCHES=(
	"${FILESDIR}"/${PN}-1.4.0_rc5-docs.patch
	)

S=${WORKDIR}/${MY_P}

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	use templates || \
		sed '/ADD_SUBDIRECTORY(resources\/templates)/d' -i CMakeLists.txt
	use examples || \
		sed '/ADD_SUBDIRECTORY(samples)/d' -i scribus/plugins/scriptplugin/CMakeLists.txt

sed \
	-e '1i#define OF(x) x' \
	-i scribus/fileunzip.cpp scribus/unzip.h scribus/ioapi.h || die

	base_src_prepare
}

src_configure() {
	mycmakeargs=(
		"-DHAVE_PYTHON=ON"
		"-DPYTHON_INCLUDE_PATH=$(python_get_includedir)"
		"-DPYTHON_LIBRARY=$(python_get_library)"
		"-DWANT_NORPATH=ON"
		"-DWANT_QTARTHUR=ON"
		"-DWANT_QT3SUPPORT=OFF"
		"-DGENTOOVERSION=${PVR}"
		$(cmake-utils_use_has spell ASPELL)
		$(cmake-utils_use_has pdf PODOFO)
		$(cmake-utils_use_want cairo)
		$(cmake-utils_use_want minimal NOHEADERINSTALL)
		)

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	mv "${ED}"/usr/share/doc/${PF}/{en,html}
	ln -sf html "${ED}"/usr/share/doc/${PF}/en

	doicon resources/icons/scribus.png
	domenu scribus.desktop
}

pkg_postinst() {
	fdo-mime_mime_database_update
}

pkg_postrm() {
	fdo-mime_mime_database_update
}

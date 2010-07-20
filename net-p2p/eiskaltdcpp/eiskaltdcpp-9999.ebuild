# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/eiskaltdcpp/eiskaltdcpp-9999.ebuild,v 1.10 2010/07/20 07:10:10 pva Exp $

EAPI="2"

LANGS="be en fr hu pl ru sr uk"
CMAKE_MIN_VERSION="2.6.0"
inherit qt4-r2 cmake-utils subversion

DESCRIPTION="Qt4 based client for DirectConnect and ADC protocols, based on DC++ library"
HOMEPAGE="http://eiskaltdc.googlecode.com/"
ESVN_REPO_URI="http://${PN%pp}.googlecode.com/svn/branches/trunk/"

LICENSE="GPL-2 GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="dbus javascript kde spell upnp"

RDEPEND="
	>=dev-libs/boost-1.34.1
	app-arch/bzip2
	sys-libs/zlib
	>=dev-libs/openssl-0.9.8
	virtual/libiconv
	>=x11-libs/qt-gui-4.4.0:4[dbus?]
	javascript? (
		x11-libs/qt-script
		x11-libs/qtscriptgenerator
		)
	kde? ( kde-base/oxygen-icons )
	spell? ( app-text/aspell )
	upnp? (
		>=net-libs/libupnp-1.6.0
		!>net-libs/libupnp-1.6.9999
		)
"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
"
DOCS="AUTHORS ChangeLog.txt"

src_configure() {
	# linguas
	local langs
	for x in ${LANGS}; do
		use linguas_${x} && langs+=" ${x}"
	done

	local mycmakeargs=(
		-DLIB_INSTALL_DIR="$(get_libdir)"
		-DFREE_SPACE_BAR_C="1"
		"$(cmake-utils_use dbus DBUS_NOTIFY)"
		"$(cmake-utils_use javascript USE_JS)"
		"$(cmake-utils_use kde USE_ICON_THEME)"
		"$(cmake-utils_use spell USE_ASPELL)"
		"-DUSE_QT=ON"
		"$(cmake-utils_use upnp USE_LIBUPNP)"
		"-DUSE_WT=OFF"
		-Dlinguas="${langs}"
	)
	cmake-utils_src_configure
}

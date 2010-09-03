# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/eiskaltdcpp/eiskaltdcpp-9999.ebuild,v 1.11 2010/09/03 07:41:04 pva Exp $

EAPI="2"

LANGS="be bg en es fr hu pl ru sr uk"
CMAKE_MIN_VERSION="2.6.0"
inherit qt4-r2 cmake-utils subversion

DESCRIPTION="Qt4 based client for DirectConnect and ADC protocols, based on DC++ library"
HOMEPAGE="http://eiskaltdc.googlecode.com/"
ESVN_REPO_URI="http://${PN%pp}.googlecode.com/svn/branches/trunk/"

LICENSE="GPL-2 GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="dbus examples -gnome -gtk -javascript kde lua +qt4 spell upnp"

RDEPEND="
	app-arch/bzip2
	sys-libs/zlib
	>=dev-libs/openssl-0.9.8
	virtual/libiconv
	sys-devel/gettext
	lua? ( >=dev-lang/lua-5.1 )
	gtk? (
		x11-libs/pango
		>=x11-libs/gtk+-2.10:2
		>=dev-libs/glib-2.10:2
		>=gnome-base/libglade-2.4:2.0
		>=x11-libs/libnotify-0.4.1
		gnome? ( gnome-base/libgnome )
	)
	qt4? (
		>=x11-libs/qt-gui-4.4.0:4[dbus?]
		javascript? (
			x11-libs/qt-script
			x11-libs/qtscriptgenerator
		)
		kde? (
			kde-base/oxygen-icons
			>=x11-libs/qt-gui-4.6.0:4
		)
		spell? ( app-text/aspell )
		upnp? (	=net-libs/libupnp-1.6* )
	)
"
DEPEND="${RDEPEND}
	>=dev-libs/boost-1.34.1
	dev-util/pkgconfig
"
DOCS="AUTHORS ChangeLog.txt"

pkg_setup() {
	use gtk && ewarn "GTK UI is very experimental, only Qt4 frontend is stable."
}

src_configure() {
	# linguas
	local langs
	for x in ${LANGS}; do
		use linguas_${x} && langs+=" ${x}"
	done

	local mycmakeargs=(
		-DLIB_INSTALL_DIR="$(get_libdir)"
		"$(cmake-utils_use lua LUA_SCRIPT)"
		"$(cmake-utils_use dbus DBUS_NOTIFY)"
		"$(cmake-utils_use javascript USE_JS)"
		"$(cmake-utils_use kde USE_ICON_THEME)"
		"$(cmake-utils_use spell USE_ASPELL)"
		"$(cmake-utils_use qt4 USE_QT)"
		"$(cmake-utils_use upnp USE_LIBUPNP)"
		"$(cmake-utils_use gtk USE_GTK)"
		"$(cmake-utils_use gnome USE_LIBGNOME2)"
		"-DUSE_WT=OFF"
		"$(cmake-utils_use examples WITH_EXAMPLES)"
		-Dlinguas="${langs}"
	)
	cmake-utils_src_configure
}

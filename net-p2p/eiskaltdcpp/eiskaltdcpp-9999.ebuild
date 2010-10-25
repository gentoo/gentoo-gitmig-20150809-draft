# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/eiskaltdcpp/eiskaltdcpp-9999.ebuild,v 1.15 2010/10/25 13:34:31 pva Exp $

EAPI="2"

LANGS="be bg en es fr hu pl ru sr uk"
CMAKE_MIN_VERSION="2.6.0"
inherit qt4-r2 cmake-utils git

DESCRIPTION="Qt4 based client for DirectConnect and ADC protocols, based on DC++ library"
HOMEPAGE="http://eiskaltdc.googlecode.com/"
EGIT_REPO_URI="git://github.com/negativ/${PN}.git"

LICENSE="GPL-2 GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="dbus +emoticons examples -gnome -gtk -javascript kde libnotify lua +qt4 sounds spell upnp"

RDEPEND="
	app-arch/bzip2
	sys-libs/zlib
	>=dev-libs/openssl-0.9.8
	virtual/libiconv
	sys-devel/gettext
	lua? ( >=dev-lang/lua-5.1 )
	upnp? ( net-libs/miniupnpc )
	gtk? (
		x11-libs/pango
		>=x11-libs/gtk+-2.10:2
		>=dev-libs/glib-2.10:2
		>=gnome-base/libglade-2.4:2.0
		libnotify? ( >=x11-libs/libnotify-0.4.1 )
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
	)
"
DEPEND="${RDEPEND}
	>=dev-libs/boost-1.34.1
	dev-util/pkgconfig
"
DOCS="AUTHORS ChangeLog.txt"

src_configure() {
	# linguas
	local langs x
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
		"$(cmake-utils_use upnp USE_MINIUPNP)"
		-DLOCAL_MINIUPNP="0"
		"$(cmake-utils_use gtk USE_GTK)"
		"$(cmake-utils_use gnome USE_LIBGNOME2)"
		"$(cmake-utils_use libnotify USE_LIBNOTIFY)"
		"$(cmake-utils_use emoticons WITH_EMOTICONS)"
		"$(cmake-utils_use examples WITH_EXAMPLES)"
		"$(cmake-utils_use lua WITH_LUASCRIPTS)"
		"$(cmake-utils_use sounds WITH_SOUNDS)"
		-Dlinguas="${langs}"
	)
	cmake-utils_src_configure
}

# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/eiskaltdcpp/eiskaltdcpp-2.2.1.ebuild,v 1.3 2011/05/24 20:59:56 maekke Exp $

EAPI="3"

LANGS="be bg cs en es fr hu pl ru sk sr uk"

[[ ${PV} = *9999* ]] && VCS_ECLASS="git" || VCS_ECLASS=""
inherit cmake-utils ${VCS_ECLASS}

DESCRIPTION="Qt4 based client for DirectConnect and ADC protocols, based on DC++ library"
HOMEPAGE="http://eiskaltdc.googlecode.com/"

LICENSE="GPL-2 GPL-3"
SLOT="0"
IUSE="cli daemon dbus +emoticons examples -gnome -gtk -javascript libnotify lua +qt4 pcre sound spell sqlite upnp"
for x in ${LANGS}; do
	IUSE="${IUSE} linguas_${x}"
done

if [[ ${PV} != *9999* ]]; then
	SRC_URI="http://${PN/pp/}.googlecode.com/files/${P}.tar.xz"
	KEYWORDS="amd64 x86"
else
	EGIT_REPO_URI="git://github.com/negativ/${PN}.git"
	KEYWORDS=""
fi

RDEPEND="
	app-arch/bzip2
	sys-libs/zlib
	>=dev-libs/openssl-0.9.8
	virtual/libiconv
	sys-devel/gettext
	cli? ( sys-libs/readline )
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
		spell? ( app-text/aspell )
		sqlite? ( x11-libs/qt-sql:4[sqlite] )
	)
	pcre? ( >=dev-libs/libpcre-4.2 )
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
		"$(cmake-utils_use spell USE_ASPELL)"
		"$(cmake-utils_use sqlite USE_QT_SQLITE)"
		"$(cmake-utils_use qt4 USE_QT)"
		"$(cmake-utils_use upnp USE_MINIUPNP)"
		-DLOCAL_MINIUPNP="0"
		"$(cmake-utils_use gtk USE_GTK)"
		"$(cmake-utils_use gnome USE_LIBGNOME2)"
		"$(cmake-utils_use libnotify USE_LIBNOTIFY)"
		"$(cmake-utils_use emoticons WITH_EMOTICONS)"
		"$(cmake-utils_use examples WITH_EXAMPLES)"
		"$(cmake-utils_use lua WITH_LUASCRIPTS)"
		"$(cmake-utils_use pcre PERL_REGEX)"
		"$(cmake-utils_use sound WITH_SOUNDS)"
		"$(cmake-utils_use cli CLI_DAEMON)"
		"$(cmake-utils_use daemon NO_UI_DAEMON)"
		-DXMLRPC_DAEMON=OFF
		-Dlinguas="${langs}"
	)
	cmake-utils_src_configure
}

# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/eiskaltdcpp/eiskaltdcpp-2.2.4.ebuild,v 1.2 2011/10/19 19:50:45 pva Exp $

EAPI="4"

LANGS="be bg cs de en es fr hu pl ru sk sr uk"

[[ ${PV} = *9999* ]] && VCS_ECLASS="git-2" || VCS_ECLASS=""
inherit cmake-utils ${VCS_ECLASS}

DESCRIPTION="Qt4 based client for DirectConnect and ADC protocols, based on DC++ library"
HOMEPAGE="http://eiskaltdc.googlecode.com/"

LICENSE="GPL-2 GPL-3"
SLOT="0"
IUSE="cli daemon dbus +dht +emoticons examples -gnome -gtk idn -javascript libnotify lua +minimal pcre +qt4 sound spell sqlite upnp xmlrpc"
for x in ${LANGS}; do
	IUSE="${IUSE} linguas_${x}"
done

REQUIRED_USE="
	emoticons? ( || ( gtk qt4 ) )
	dbus? ( qt4 )
	gnome? ( gtk )
	javascript? ( qt4 )
	libnotify? ( gtk )
	spell? ( qt4 )
	sound? ( || ( gtk qt4 ) )
	sqlite? ( qt4 )
	xmlrpc? ( daemon )
"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="http://${PN/pp/}.googlecode.com/files/${P}.tar.xz"
	KEYWORDS="~amd64 ~x86"
else
	EGIT_REPO_URI="git://github.com/negativ/${PN}.git"
	KEYWORDS=""
fi

RDEPEND="
	app-arch/bzip2
	>=dev-libs/openssl-0.9.8
	sys-devel/gettext
	sys-libs/zlib
	virtual/libiconv
	idn? ( net-dns/libidn )
	lua? ( >=dev-lang/lua-5.1 )
	pcre? ( >=dev-libs/libpcre-4.2 )
	upnp? ( net-libs/miniupnpc )
	cli? (
		>=dev-lang/perl-5.10
		dev-perl/RPC-XML
		dev-perl/Term-ShellUI
	)
	daemon? ( xmlrpc? ( >=dev-libs/xmlrpc-c-1.19.0[abyss,cxx] ) )
	gtk? (
		x11-libs/pango
		>=x11-libs/gtk+-2.18:2
		>=dev-libs/glib-2.18:2
		x11-themes/hicolor-icon-theme
		gnome? ( gnome-base/libgnome )
		libnotify? ( >=x11-libs/libnotify-0.4.1 )
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
"
DEPEND="${RDEPEND}
	>=dev-libs/boost-1.34.1
	dev-util/pkgconfig
"
DOCS="AUTHORS ChangeLog.txt"

pkg_pretend() {
	if [[ ${MERGE_TYPE} != binary ]]; then
		[[ $(gcc-major-version) -lt 4 ]] || \
				( [[ $(gcc-major-version) -eq 4 && $(gcc-minor-version) -le 3 ]] ) \
			&& die "Sorry, but gcc-4.3 and earlier won't work."
	fi
}

src_configure() {
	# linguas
	local langs x
	for x in ${LANGS}; do
		use linguas_${x} && langs+=" ${x}"
	done

	local mycmakeargs=(
		-DLIB_INSTALL_DIR="$(get_libdir)"
		-Dlinguas="${langs}"
		-DLOCAL_MINIUPNP=OFF
		"$(cmake-utils_use cli USE_CLI)"
		"$(cmake-utils_use daemon NO_UI_DAEMON)"
		"$(cmake-utils_use dbus DBUS_NOTIFY)"
		"$(cmake-utils_use dht WITH_DHT)"
		"$(cmake-utils_use emoticons WITH_EMOTICONS)"
		"$(cmake-utils_use examples WITH_EXAMPLES)"
		"$(cmake-utils_use gnome USE_LIBGNOME2)"
		"$(cmake-utils_use gtk USE_GTK)"
		"$(cmake-utils_use idn USE_IDNA)"
		"$(cmake-utils_use javascript USE_JS)"
		"$(cmake-utils_use libnotify USE_LIBNOTIFY)"
		"$(cmake-utils_use lua LUA_SCRIPT)"
		"$(cmake-utils_use lua WITH_LUASCRIPTS)"
		"$(cmake-utils_use !minimal WITH_DEV_FILES)"
		"$(cmake-utils_use pcre PERL_REGEX)"
		"$(cmake-utils_use qt4 USE_QT)"
		"$(cmake-utils_use sound WITH_SOUNDS)"
		"$(cmake-utils_use spell USE_ASPELL)"
		"$(cmake-utils_use sqlite USE_QT_SQLITE)"
		"$(cmake-utils_use upnp USE_MINIUPNP)"
		"$(cmake-utils_use xmlrpc XMLRPC_DAEMON)"
	)
	cmake-utils_src_configure
}

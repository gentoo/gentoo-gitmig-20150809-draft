# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/qbittorrent/qbittorrent-9999.ebuild,v 1.2 2011/03/04 19:56:15 hwoarang Exp $

EAPI="2"
PYTHON_DEPEND="2"

inherit python confutils qt4-r2 versionator subversion

DESCRIPTION="BitTorrent client in C++ and Qt"
HOMEPAGE="http://www.qbittorrent.org/"

LICENSE="GPL-2"
SLOT="0"
ESVN_REPO_URI="https://qbittorrent.svn.sourceforge.net/svnroot/qbittorrent/trunk"
KEYWORDS=""

IUSE="+X geoip libnotify"

QT_MIN="4.7.1"
# boost version so that we always have thread support
CDEPEND="net-libs/rb_libtorrent
	>=x11-libs/qt-core-${QT_MIN}:4
	>=x11-libs/qt-dbus-${QT_MIN}:4
	X? ( >=x11-libs/qt-gui-${QT_MIN}:4
		libnotify? ( >=x11-libs/qt-gui-${QT_MIN}:4[glib] ) )
	dev-libs/boost"
DEPEND="${CDEPEND}
	dev-util/pkgconfig"
RDEPEND="${CDEPEND}
	geoip? ( dev-libs/geoip )
	libnotify? ( x11-libs/libnotify )"

DOCS="AUTHORS Changelog NEWS README TODO"

pkg_setup() {
	confutils_use_depend_all libnotify X
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	# Respect LDFLAGS
	sed -i -e 's/-Wl,--as-needed/$(LDFLAGS)/g' src/src.pro
	qt4-r2_src_prepare
}

src_configure() {
	local myconf
	use X         || myconf+=" --disable-gui"
	use geoip     || myconf+=" --disable-geoip-database"
	use libnotify || myconf+=" --disable-libnotify"

	# slotted boost detection, bug #309415
	BOOST_PKG="$(best_version ">=dev-libs/boost-1.34.1")"
	BOOST_VER="$(get_version_component_range 1-2 "${BOOST_PKG/*boost-/}")"
	BOOST_VER="$(replace_all_version_separators _ "${BOOST_VER}")"
	myconf+=" --with-libboost-inc=/usr/include/boost-${BOOST_VER}"

	# econf fails, since this uses qconf
	./configure --prefix=/usr --qtdir=/usr ${myconf} || die "configure failed"
	eqmake4
}

# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/transmission-remote-gtk/transmission-remote-gtk-1.0.2.ebuild,v 1.1 2012/07/04 08:15:33 ssuominen Exp $

EAPI=4
inherit fdo-mime gnome2-utils

DESCRIPTION="GTK+ client for management of the Transmission BitTorrent client, over HTTP RPC"
HOMEPAGE="http://code.google.com/p/transmission-remote-gtk"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ayatana debug geoip libproxy"

RESTRICT="test"

RDEPEND=">=dev-libs/glib-2.28
	>=dev-libs/json-glib-0.12.6
	net-misc/curl
	x11-libs/gtk+:3
	>=x11-libs/libnotify-0.7
	ayatana? ( dev-libs/libappindicator:3 )
	geoip? ( dev-libs/geoip )
	libproxy? ( net-libs/libproxy )"
DEPEND="${RDEPEND}
	dev-util/intltool
	sys-devel/gettext
	virtual/pkgconfig"

DOCS="AUTHORS ChangeLog README"

src_configure() {
	econf \
		$(use_enable debug) \
		--enable-gtk3 \
		$(use_with geoip libgeoip) \
		$(use_with libproxy) \
		$(use_with ayatana libappindicator)
}

pkg_preinst() {	gnome2_icon_savelist; }
pkg_postinst() { fdo-mime_desktop_database_update; gnome2_icon_cache_update; }
pkg_postrm() { fdo-mime_desktop_database_update; gnome2_icon_cache_update; }

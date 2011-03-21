# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/gnome-bluetooth/gnome-bluetooth-2.28.6.ebuild,v 1.9 2011/03/21 22:21:43 nirbheek Exp $

EAPI="2"

inherit gnome2

DESCRIPTION="Fork of bluez-gnome focused on integration with GNOME"
HOMEPAGE="http://live.gnome.org/GnomeBluetooth"
LICENSE="GPL-2 LGPL-2.1"
SLOT="2"
IUSE="doc"
KEYWORDS="amd64 ppc x86"

# XXX: gtk+-2.18 required, configure.ac lies, bug 298534
COMMON_DEPEND=">=dev-libs/glib-2.16:2
	>=x11-libs/gtk+-2.18:2
	>=x11-libs/libnotify-0.4.3
	>=gnome-base/gconf-2.6:2
	>=dev-libs/dbus-glib-0.74
	dev-libs/libunique:1"
RDEPEND="${COMMON_DEPEND}
	>=net-wireless/bluez-4.34
	app-mobilephone/obexd"
DEPEND="${COMMON_DEPEND}
	!!net-wireless/bluez-gnome
	app-text/gnome-doc-utils
	app-text/scrollkeeper
	dev-libs/libxml2
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/gettext
	x11-proto/xproto
	gnome-base/gnome-common
	dev-util/gtk-doc-am
	doc? ( >=dev-util/gtk-doc-1.9 )"

DOCS="AUTHORS README NEWS ChangeLog"
G2CONF="${G2CONF}
--disable-desktop-update
--disable-icon-update
--disable-introspection"

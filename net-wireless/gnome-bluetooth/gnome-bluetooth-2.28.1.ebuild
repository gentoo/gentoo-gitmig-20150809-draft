# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/gnome-bluetooth/gnome-bluetooth-2.28.1.ebuild,v 1.8 2009/11/21 15:13:09 armin76 Exp $

EAPI="2"

inherit autotools eutils gnome2

DESCRIPTION="Fork of bluez-gnome focused on integration with GNOME"
HOMEPAGE="http://live.gnome.org/GnomeBluetooth"
LICENSE="GPL-2 LGPL-2.1"
SLOT="2"
IUSE="doc"
KEYWORDS="~amd64 ~hppa ~ppc ~x86"

COMMON_DEPEND=">=dev-libs/glib-2.16
	>=x11-libs/gtk+-2.15
	>=x11-libs/libnotify-0.4.3
	>=gnome-base/gconf-2.6
	>=dev-libs/dbus-glib-0.74
	dev-libs/libunique"
RDEPEND="${COMMON_DEPEND}
	>=net-wireless/bluez-4.34
	|| (
		app-mobilephone/obexd
		>=app-mobilephone/obex-data-server-0.4 )"
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

src_prepare() {
	# Patch is from upstream 2.28 branch, bug 287043
	epatch "${FILESDIR}/${P}-fix-smp-build.patch"

	intltoolize --force --copy --automake || die "intltoolize failed"
	eautoreconf
}

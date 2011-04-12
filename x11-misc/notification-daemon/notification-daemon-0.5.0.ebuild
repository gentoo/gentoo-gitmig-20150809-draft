# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/notification-daemon/notification-daemon-0.5.0.ebuild,v 1.6 2011/04/12 21:01:51 maekke Exp $

EAPI=3
GCONF_DEBUG=no
inherit eutils gnome2

DESCRIPTION="Notification daemon"
HOMEPAGE="http://www.galago-project.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE=""

RDEPEND=">=dev-libs/glib-2.4:2
	>=x11-libs/gtk+-2.18:2
	>=gnome-base/gconf-2.4:2
	>=dev-libs/dbus-glib-0.78
	>=sys-apps/dbus-1
	>=media-libs/libcanberra-0.4[gtk]
	x11-libs/libnotify
	x11-libs/libwnck:1
	x11-libs/libX11
"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.40
	>=sys-devel/gettext-0.14
	!xfce-extra/xfce4-notifyd
	!x11-misc/notify-osd"

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS"
	G2CONF="${G2CONF} --disable-static"
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-libnotify-0.7.patch
	gnome2_src_prepare
}

src_install() {
	gnome2_src_install
	find "${ED}" -name "*.la" -delete
}

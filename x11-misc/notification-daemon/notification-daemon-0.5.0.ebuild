# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/notification-daemon/notification-daemon-0.5.0.ebuild,v 1.1 2011/01/24 23:22:25 eva Exp $

EAPI="3"
GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="Notifications daemon"
HOMEPAGE="http://www.galago-project.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE=""

RDEPEND=">=dev-libs/glib-2.4:2
	>=x11-libs/gtk+-2.18:2
	>=gnome-base/gconf-2.4
	>=dev-libs/dbus-glib-0.78
	>=sys-apps/dbus-1
	>=media-libs/libcanberra-0.4[gtk]
	x11-libs/libnotify
	x11-libs/libwnck
	x11-libs/libX11
"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.40
	>=sys-devel/gettext-0.14
	!xfce-extra/xfce4-notifyd"

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS"
	G2CONF="${G2CONF} --disable-static"
}

src_install() {
	gnome2_src_install
	find "${ED}" -name "*.la" -delete || die "la files removal failed"
}

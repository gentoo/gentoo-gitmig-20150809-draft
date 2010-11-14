# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-notifyd/xfce4-notifyd-0.1.0_p20101114.ebuild,v 1.1 2010/11/14 09:43:26 ssuominen Exp $

EAPI=3
EAUTORECONF=yes
inherit xfconf

DESCRIPTION="A simple notification daemon for Xfce4"
HOMEPAGE="http://spuriousinterrupt.org/projects/xfce4-notifyd"
SRC_URI="http://dev.gentoo.org/~ssuominen/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug libsexy"

RDEPEND="xfce-base/libxfce4util
	xfce-base/libxfce4ui
	xfce-base/xfconf
	>=x11-libs/gtk+-2.14:2
	>=sys-apps/dbus-1.4.0
	>=dev-libs/dbus-glib-0.88
	>=gnome-base/libglade-2.6
	libsexy? ( >=x11-libs/libsexy-0.1.6 )
	!<x11-libs/libnotify-0.4.5
	!x11-misc/notification-daemon"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	sys-devel/gettext
	xfce-base/exo"

pkg_setup() {
	XFCONF=(
		--enable-maintainer-mode
		--disable-dependency-tracking
		$(use_enable libsexy)
		$(xfconf_use_debug)
		)

	DOCS="AUTHORS ChangeLog NEWS README TODO"
}

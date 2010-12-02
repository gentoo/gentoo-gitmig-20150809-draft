# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-notifyd/xfce4-notifyd-0.2.0-r1.ebuild,v 1.1 2010/12/02 17:08:36 ssuominen Exp $

EAPI=3
inherit xfconf

DESCRIPTION="A simple notification daemon for Xfce4"
HOMEPAGE="http://goodies.xfce.org/projects/applications/xfce4-notifyd"
SRC_URI="mirror://xfce/src/apps/${PN}/0.2/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND="xfce-base/libxfce4util
	xfce-base/libxfce4ui
	xfce-base/xfconf
	>=x11-libs/gtk+-2.14:2
	>=sys-apps/dbus-1.4.0
	>=dev-libs/dbus-glib-0.88
	!<x11-libs/libnotify-0.4.5
	!x11-misc/notification-daemon"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	sys-devel/gettext"

pkg_setup() {
	PATCHES=( "${FILESDIR}"/${P}-load_icon_with_path.patch )

	XFCONF=(
		--disable-dependency-tracking
		$(xfconf_use_debug)
		)

	DOCS="AUTHORS NEWS README TODO"
}

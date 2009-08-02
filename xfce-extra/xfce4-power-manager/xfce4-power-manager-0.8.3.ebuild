# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-power-manager/xfce4-power-manager-0.8.3.ebuild,v 1.1 2009/08/02 20:25:24 darkside Exp $

EAPI="2"

inherit xfconf

DESCRIPTION="Xfce4 power manager"
HOMEPAGE="http://goodies.xfce.org/projects/applications/xfce4-power-manager"
SRC_URI="http://archive.xfce.org/src/apps/${PN}/0.8/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug +xfce"

RDEPEND=">=dev-libs/dbus-glib-0.70
	>=dev-libs/glib-2.16:2
	gnome-base/libglade
	>=sys-apps/dbus-0.60
	>=dev-libs/dbus-glib-0.70
	>=sys-apps/hal-0.5.6
	>=x11-libs/gtk+-2.12.0:2
	>=x11-libs/libnotify-0.4.1
	>=xfce-base/libxfce4util-4.6.0
	>=xfce-base/libxfcegui4-4.6.0
	>=xfce-base/xfconf-4.6.0
	xfce? ( >=xfce-base/xfce4-panel-4.6.0 )"
DEPEND="${RDEPEND}
	dev-util/intltool"

pkg_setup() {
	XFCE_CONFIG+=" $(use_enable xfce panel-plugins)"
	DOCS="AUTHORS NEWS README TODO"
}

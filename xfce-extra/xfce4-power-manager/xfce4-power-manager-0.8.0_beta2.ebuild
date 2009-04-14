# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-power-manager/xfce4-power-manager-0.8.0_beta2.ebuild,v 1.1 2009/04/14 08:16:37 angelos Exp $

EAPI=1

MY_PV=${PV/_}
inherit xfce4

XFCE_VERSION=4.5.90

xfce4_goodies

DESCRIPTION="Xfce4 power manager"
KEYWORDS="~amd64 ~x86"
IUSE="debug +xfce"

RDEPEND=">=dev-libs/dbus-glib-0.70
	>=dev-libs/glib-2.16:2
	gnome-base/libglade
	>=sys-apps/dbus-0.60
	>=sys-apps/hal-0.5.6
	>=x11-libs/gtk+-2.10:2
	>=x11-libs/libnotify-0.4.1
	>=xfce-base/libxfce4util-${XFCE_VERSION}
	>=xfce-base/libxfcegui4-${XFCE_VERSION}
	>=xfce-base/xfconf-${XFCE_VERSION}
	xfce? ( >=xfce-base/xfce4-panel-${XFCE_VERSION} )"
DEPEND="${RDEPEND}
	dev-util/intltool"

pkg_setup() {
	XFCE_CONFIG+=" $(use_enable xfce panel-plugins)"
}

DOCS="AUTHORS NEWS README TODO"

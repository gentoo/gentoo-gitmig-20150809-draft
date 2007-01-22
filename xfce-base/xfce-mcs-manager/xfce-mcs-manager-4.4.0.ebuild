# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfce-mcs-manager/xfce-mcs-manager-4.4.0.ebuild,v 1.1 2007/01/22 02:08:25 nichoj Exp $

inherit gnome2 xfce44

xfce44

DESCRIPTION="Xfce4 MCS Manager"
LICENSE="LGPL-2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"

RDEPEND=">=dev-libs/glib-2
	>=x11-libs/gtk+-2.6
	>=xfce-base/libxfce4mcs-${PV}
	>=xfce-base/libxfce4util-${PV}
	>=xfce-base/libxfcegui4-${PV}
	media-libs/libpng"

xfce44_core_package

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}



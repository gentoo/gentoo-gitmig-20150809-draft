# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfce-mcs-manager/xfce-mcs-manager-4.4.0.ebuild,v 1.3 2007/01/23 22:38:16 welp Exp $

inherit gnome2-utils xfce44

xfce44

DESCRIPTION="Xfce4 MCS Manager"
LICENSE="LGPL-2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"

IUSE="debug"

RDEPEND=">=dev-libs/glib-2
	>=x11-libs/gtk+-2.6
	>=xfce-base/libxfce4mcs-${XFCE_MASTER_VERSION}
	>=xfce-base/libxfce4util-${XFCE_MASTER_VERSION}
	>=xfce-base/libxfcegui4-${XFCE_MASTER_VERSION}
	media-libs/libpng"

xfce44_core_package

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}



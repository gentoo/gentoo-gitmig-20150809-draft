# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfprint/xfprint-4.4.0.ebuild,v 1.1 2007/01/22 02:11:47 nichoj Exp $

inherit xfce44 gnome2-utils

xfce44

DESCRIPTION="Xfce4 Printing System"
LICENSE="BSD"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"

IUSE="debug"

RDEPEND="net-print/cups
	>=dev-libs/glib-2.2
	>=x11-libs/gtk+-2.2
	>=xfce-base/libxfce4mcs-${PV}
	>=xfce-base/libxfce4util-${PV}
	>=xfce-base/libxfcegui4-${PV}
	dev-libs/libgcrypt
	dev-libs/libgpg-error
	media-libs/libpng
	net-libs/gnutls
	app-text/a2ps"
DEPEND="${RDEPEND}
	>=xfce-base/xfce-mcs-manager-${PV}"

# CUPS includes support for LPR
XFCE_CONFIG="--enable-bsdlpr --enable-cups"

xfce44_core_package

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}

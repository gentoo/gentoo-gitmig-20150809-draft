# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfce-utils/xfce-utils-4.4.0.ebuild,v 1.1 2007/01/22 02:09:29 nichoj Exp $

inherit xfce44

xfce44

DESCRIPTION="Utilities for Xfce4"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc debug"

RDEPEND="|| ( x11-apps/xrdb
	virtual/x11 )
	>=dev-libs/glib-2.2
	>=x11-libs/gtk+-2.2
	media-libs/libpng
	>=xfce-base/libxfce4util-${PV}
	>=xfce-base/libxfcegui4-${PV}
	>=xfce-base/libxfce4mcs-${PV}
	>=xfce-base/xfce-mcs-manager-${PV}"

XFCE_CONFIG="${XFCE_CONFIG} --enable-gdm --with-vendor-info=Gentoo"

xfce44_core_package

src_install() {
	xfce44_src_install

	insinto /usr/share/xfce4
	newins ${FILESDIR}/Gentoo Gentoo

	if use doc; then
		dodoc AUTHORS README ChangeLog HACKING NEWS THANKS TODO
	fi
}

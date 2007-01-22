# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfdesktop/xfdesktop-4.4.0.ebuild,v 1.1 2007/01/22 02:11:45 nichoj Exp $

inherit xfce44 eutils

xfce44

DESCRIPTION="Xfce4 desktop manager"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"

IUSE="debug exo panel-plugin thunar-vfs"

DEPEND="sys-apps/dbus"
RDEPEND="|| ( (
			x11-libs/libX11
			x11-libs/libICE
			x11-libs/libSM )
		virtual/x11 )
	>=dev-libs/glib-2.2
	>=x11-libs/gtk+-2.2
	>=xfce-base/libxfce4mcs-${PV}
	>=xfce-base/libxfce4util-${PV}
	>=xfce-base/libxfcegui4-${PV}
	thunar-vfs? ( >=xfce-base/thunar-0.8.0 )
	panel-plugin? ( >=xfce-base/xfce4-panel-${PV} )
	>=xfce-base/xfce-mcs-manager-${PV}
	media-libs/libpng
	exo? ( >=xfce-extra/exo-0.3.2 )
	${DEPEND}"

if ! use thunar-vfs; then
	XFCE_CONFIG="${XFCE_CONFIG} --disable-thunar-vfs --disable-thunarx"
fi

if ! use exo; then
	XFCE_CONFIG="${XFCE_CONFIG} --disable-exo"
fi

if ! use panel-plugin; then
	XFCE_CONFIG="${XFCE_CONFIG} --disable-panel-plugin"
fi

xfce44_core_package

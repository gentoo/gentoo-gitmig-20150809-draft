# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfdesktop/xfdesktop-4.3.99.2.ebuild,v 1.2 2006/12/07 03:28:04 beu Exp $

inherit xfce44

xfce44_beta

DESCRIPTION="Xfce 4 desktop manager"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"

IUSE="exo panel-plugin thunar-vfs"

DEPEND="sys-apps/dbus"
RDEPEND="|| ( (
			x11-libs/libX11
			x11-libs/libICE
			x11-libs/libSM )
		virtual/x11 )
	>=dev-libs/glib-2.2
	>=x11-libs/gtk+-2.2
	~xfce-base/libxfce4mcs-${PV}
	~xfce-base/libxfce4util-${PV}
	~xfce-base/libxfcegui4-${PV}
	thunar-vfs? ( ~xfce-base/thunar-0.5.0_rc2 )
	panel-plugin? ( ~xfce-base/xfce4-panel-${PV} )
	~xfce-base/xfce-mcs-manager-${PV}
	media-libs/libpng
	exo? ( >=xfce-extra/exo-0.3.1.12_rc2 )
	${DEPEND}"

if ! use thunar-vfs; then
	XFCE_CONFIG="--disable-thunar-vfs --disable-thunarx"
fi

if ! use exo; then
	XFCE_CONFIG="${XFCE_CONFIG} --disable-exo"
fi

if ! use panel-plugin; then
	XFCE_CONFIG="${XFCE_CONFIG} --disable-panel-plugin"
fi

xfce44_core_package

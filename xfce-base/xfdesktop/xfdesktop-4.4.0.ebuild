# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfdesktop/xfdesktop-4.4.0.ebuild,v 1.2 2007/01/23 18:03:35 welp Exp $

inherit xfce44

xfce44

DESCRIPTION="Xfce4 desktop manager"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"

IUSE="debug exo panel-plugin thunar-vfs"

RDEPEND="sys-apps/dbus
	x11-libs/libX11
	x11-libs/libICE
	x11-libs/libSM
	>=dev-libs/glib-2.2
	>=x11-libs/gtk+-2.2
	>=xfce-base/libxfce4mcs-${XFCE_MASTER_VERSION}
	>=xfce-base/libxfce4util-${XFCE_MASTER_VERSION}
	>=xfce-base/libxfcegui4-${XFCE_MASTER_VERSION}
	thunar-vfs? ( >=xfce-base/thunar-${THUNAR_MASTER_VERSION} )
	panel-plugin? ( >=xfce-base/xfce4-panel-${XFCE_MASTER_VERSION} )
	>=xfce-base/xfce-mcs-manager-${XFCE_MASTER_VERSION}
	media-libs/libpng
	exo? ( >=xfce-extra/exo-0.3.2 )"
DEPEND="${RDEPEND}"

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

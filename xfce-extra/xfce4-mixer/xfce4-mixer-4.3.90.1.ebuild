# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-mixer/xfce4-mixer-4.3.90.1.ebuild,v 1.1 2006/04/20 05:57:50 dostrow Exp $

inherit xfce44

xfce44_beta

DESCRIPTION="Xfce 4 mixer panel plugin"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"

IUSE="alsa"

RDEPEND=">=dev-libs/glib-2
	dev-libs/libxml2
	>=x11-libs/gtk+-2.2
	~xfce-base/libxfce4mcs-${PV}
	~xfce-base/libxfce4util-${PV}
	~xfce-base/libxfcegui4-${PV}
	~xfce-base/xfce4-panel-${PV}
	media-libs/libpng
	alsa? ( media-libs/alsa-lib )"
DEPEND="${RDEPEND}
	|| ( x11-proto/xproto virtual/x11 )
	~xfce-base/xfce-mcs-manager-${PV}"

if use alsa; then
	XFCE_CONFIG="--with-sound=alsa"
fi

xfce44_core_package

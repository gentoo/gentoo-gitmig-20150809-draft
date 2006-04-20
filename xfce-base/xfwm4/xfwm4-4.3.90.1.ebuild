# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfwm4/xfwm4-4.3.90.1.ebuild,v 1.1 2006/04/20 05:29:54 dostrow Exp $

inherit xfce44

xfce44_beta

DESCRIPTION="Xfce 4 window manager"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"

IUSE="startup-notification xcomposite"

RDEPEND="|| ( ( x11-libs/libX11
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libXpm
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libXext )
	virtual/x11 )
	xcomposite? ( || ( ( x11-libs/libXcomposite
		x11-libs/libXdamage
		x11-libs/libXfixes )
		virtual/x11 ) )
	>=dev-libs/glib-2
	>=x11-libs/gtk+-2.6
	x11-libs/pango
	startup-notification? ( >=x11-libs/startup-notification-0.5 )
	~xfce-base/libxfce4mcs-${PV}
	~xfce-base/libxfce4util-${PV}
	~xfce-base/libxfcegui4-${PV}"
DEPEND="${RDEPEND}
	|| ( ( x11-proto/xextproto
	x11-proto/xproto )
	virtual/x11 )
	~xfce-base/xfce-mcs-manager-${PV}"

XFCE_CONFIG="--enable-randr $(use_enable xcomposite compositor) \
	$(use_enable startup-notification)"

xfce44_core_package

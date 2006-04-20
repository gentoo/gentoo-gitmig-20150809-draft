# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfce4-panel/xfce4-panel-4.3.90.1.ebuild,v 1.1 2006/04/20 05:26:36 dostrow Exp $

inherit xfce44

xfce44_beta

DESCRIPTION="Xfce 4 panel"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"

IUSE="startup-notification"

RDEPEND="|| ( ( x11-libs/libX11
	x11-libs/libICE
	x11-libs/libSM )
	virtual/x11 )
	>=dev-libs/glib-2
	>=x11-libs/gtk+-2.6
	~xfce-base/libxfce4util-${PV}
	~xfce-base/libxfcegui4-${PV}
	media-libs/libpng
	startup-notification? ( >=x11-libs/startup-notification-0.5 )
	>=dev-util/gtk-doc-1
	!<xfce-extra/xfce4-battery-0.4
	!<xfce-extra/xfce4-clipman-0.5
	!<xfce-extra/xfce4-cpugrap-0.3
	!<xfce-extra/xfce4-datetime-0.4
	!<xfce-extra/xfce4-diskperf-2.0
	!<xfce-extra/xfce4-fsguard-0.3
	!<xfce-extra/xfce4-genmon-2.0
	!<xfce-extra/xfce4-megahertz-0.2
	!<xfce-extra/xfce4-minicmd-0.4
	!<xfce-extra/xfce4-modemlights-0.2
	!<xfce-extra/xfce4-mount-0.4
	!<xfce-extra/xfce4-netload-0.4
	!<xfce-extra/xfce4-notes-0.11
	!<xfce-extra/xfce4-sensors-0.8
	!<xfce-extra/xfce4-systemload-0.4
	!<xfce-extra/xfce4-wavelan-0.5
	!<xfce-extra/xfce4-weather-0.5
	!<xfce-extra/xfce4-websearch-0.2
	!<xfce-extra/xfce4-windowlist-0.2
	!<xfce-extra/xfce4-xmms-0.4"

XFCE_CONFIG="$(use_enable startup-notification)"

xfce44_core_package

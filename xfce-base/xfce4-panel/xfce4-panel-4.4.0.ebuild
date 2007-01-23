# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfce4-panel/xfce4-panel-4.4.0.ebuild,v 1.4 2007/01/23 21:36:05 welp Exp $

inherit xfce44

xfce44

DESCRIPTION="Xfce4 panel"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"

IUSE="debug startup-notification"

RDEPEND="x11-libs/libX11
	x11-libs/libICE
	x11-libs/libSM
	>=dev-libs/glib-2
	>=x11-libs/gtk+-2.6
	>=xfce-base/libxfce4util-${XFCE_MASTER_VERSION}
	>=xfce-base/libxfcegui4-${XFCE_MASTER_VERSION}
	>=xfce-base/xfce-mcs-manager-${XFCE_MASTER_VERSION}
	media-libs/libpng
	startup-notification? ( >=x11-libs/startup-notification-0.5 )"
DEPEND="${RDEPEND}
	!xfce-extra/xfce4-panelmenu
	!xfce-extra/xfce4-showdesktop
	!xfce-extra/xfce4-systray
	!xfce-extra/xfce4-taskbar
	!xfce-extra/xfce4-toys
	!xfce-extra/xfce4-windowlist
	!xfce-extra/xfce4-trigger-launcher
	>=dev-util/gtk-doc-1"

XFCE_CONFIG="${XFCE_CONFIG} $(use_enable startup-notification)"

xfce44_core_package

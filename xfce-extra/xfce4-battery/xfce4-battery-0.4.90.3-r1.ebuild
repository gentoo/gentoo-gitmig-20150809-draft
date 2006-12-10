# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-battery/xfce4-battery-0.4.90.3-r1.ebuild,v 1.1 2006/12/10 19:47:34 nichoj Exp $

inherit xfce44

xfce44_goodies_panel_plugin

DESCRIPTION="Xfce4 battery status panel plugin"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug"

DEPEND="dev-util/intltool
	>=x11-libs/gtk+-2.6
	>=xfce-base/libxfce4util-4.3.90.2
	>=xfce-base/libxfcegui4-4.3.90.2
	>=xfce-base/xfce4-panel-4.3.90.2"
RDEPEND=""

XFCE_CONFIG="$(use_enable debug)"

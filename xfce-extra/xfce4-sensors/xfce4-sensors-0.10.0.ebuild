# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-sensors/xfce4-sensors-0.10.0.ebuild,v 1.3 2007/02/26 20:47:09 drac Exp $

inherit xfce44

xfce44

DESCRIPTION="lm_sensors panel plugin"
KEYWORDS="~amd64 ~x86 ~ppc"

RDEPEND="sys-apps/lm_sensors"

xfce44_goodies_panel_plugin

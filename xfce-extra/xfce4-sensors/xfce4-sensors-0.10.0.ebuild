# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-sensors/xfce4-sensors-0.10.0.ebuild,v 1.1 2006/12/06 05:01:05 nichoj Exp $

inherit xfce44

DESCRIPTION="Xfce4 panel lm-sensors plugin"
KEYWORDS="~amd64 ~x86 ~ppc"

RDEPEND="sys-apps/lm_sensors"

xfce44_beta
xfce44_goodies_panel_plugin

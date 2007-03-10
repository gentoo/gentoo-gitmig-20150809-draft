# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-sensors/xfce4-sensors-0.10.0.ebuild,v 1.6 2007/03/10 18:07:14 nixnut Exp $

inherit xfce44

xfce44

DESCRIPTION="lm_sensors panel plugin"
KEYWORDS="amd64 ppc x86"

RDEPEND="sys-apps/lm_sensors"

xfce44_goodies_panel_plugin

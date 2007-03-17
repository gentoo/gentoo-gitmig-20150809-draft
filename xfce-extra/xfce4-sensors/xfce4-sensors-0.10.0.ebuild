# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-sensors/xfce4-sensors-0.10.0.ebuild,v 1.7 2007/03/17 19:03:51 drac Exp $

inherit xfce44

xfce44

DESCRIPTION="lm_sensors panel plugin"
KEYWORDS="amd64 ppc x86"

RDEPEND="sys-apps/lm_sensors"
DEPEND="dev-util/intltool"

DOCS="AUTHORS ChangeLog NEWS README TODO"

xfce44_goodies_panel_plugin

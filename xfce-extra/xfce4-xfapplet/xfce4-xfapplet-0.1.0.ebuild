# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-xfapplet/xfce4-xfapplet-0.1.0.ebuild,v 1.1 2006/12/06 04:22:49 nichoj Exp $

inherit xfce44

xfce44_beta
xfce44_goodies_panel_plugin

DESCRIPTION="A panel plugin for using GNOME applets"
KEYWORDS="~x86"
RDEPEND=">=xfce-base/libxfce4util-4.3.90
	>=gnome-base/orbit-2.12.5
	gnome-base/gnome-panel"
DEPEND="${RDEPEND}"

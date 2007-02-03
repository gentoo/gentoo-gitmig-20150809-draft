# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-xfapplet/xfce4-xfapplet-0.1.0.ebuild,v 1.6 2007/02/03 00:01:50 jer Exp $

inherit xfce44

xfce44_beta
xfce44_goodies_panel_plugin

DESCRIPTION="A panel plugin for using GNOME applets"
KEYWORDS="~amd64 ~hppa ~ppc64 ~sparc ~x86"
RDEPEND=">=xfce-base/libxfce4util-${XFCE_MASTER_VERSION}
	>=xfce-base/xfce4-panel-${XFCE_MASTER_VERSION}
	>=gnome-base/orbit-2.12.5
	gnome-base/gnome-panel"
DEPEND="${RDEPEND}"

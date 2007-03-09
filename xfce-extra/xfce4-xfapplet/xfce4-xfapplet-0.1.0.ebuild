# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-xfapplet/xfce4-xfapplet-0.1.0.ebuild,v 1.12 2007/03/09 18:48:16 jer Exp $

inherit xfce44

xfce44

DESCRIPTION="Panel plugin to support GNOME applets"
KEYWORDS="~amd64 hppa ~ppc ~ppc64 sparc x86"
RDEPEND=">=gnome-base/orbit-2.12.5
	gnome-base/gnome-panel"
DEPEND="${RDEPEND}"

xfce44_goodies_panel_plugin

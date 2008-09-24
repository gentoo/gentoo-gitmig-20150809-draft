# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-modemlights/xfce4-modemlights-0.1.3.99.ebuild,v 1.1 2008/09/24 16:41:01 angelos Exp $

EAPI=1

inherit xfce44

xfce44

DESCRIPTION="a panel plugin to turn dialup (ppp) connections on/off"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND=">=dev-libs/glib-2.8:2
	>=x11-libs/gtk+-2.6:2
	>=xfce-base/libxfce4util-4.4
	>=xfce-base/libxfcegui4-4.4"

DOCS="AUTHORS ChangeLog NEWS README"

xfce44_goodies_panel_plugin

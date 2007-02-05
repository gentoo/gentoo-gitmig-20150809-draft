# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-eyes/xfce4-eyes-4.4.0.ebuild,v 1.2 2007/02/05 02:15:13 nichoj Exp $

inherit xfce44

xfce44
xfce44_goodies_panel_plugin

DESCRIPTION="Eyes is a panel plugin that adds eyes which watch your every step."
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="dev-util/pkgconfig
	dev-util/intltool"

DOCS="AUTHORS ChangeLog NEWS README"

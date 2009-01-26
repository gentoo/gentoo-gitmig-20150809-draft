# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-wmdock/xfce4-wmdock-0.3.1.ebuild,v 1.1 2009/01/26 00:00:03 angelos Exp $

inherit xfce44

xfce44_goodies_panel_plugin

DESCRIPTION="a compatibility layer for running WindowMaker dockapps on Xfce4."
HOMEPAGE="http://www.ibh.de/~ellguth/xfce4-wmdock-plugin.html"

KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE="debug"

RDEPEND="x11-libs/libwnck"
DEPEND="${RDEPEND}
	dev-util/intltool"

DOCS="AUTHORS ChangeLog README TODO"

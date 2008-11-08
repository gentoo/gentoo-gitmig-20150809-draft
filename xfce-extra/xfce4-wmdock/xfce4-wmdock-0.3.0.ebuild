# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-wmdock/xfce4-wmdock-0.3.0.ebuild,v 1.4 2008/11/08 17:11:21 armin76 Exp $

inherit xfce44

xfce44_panel_plugin

DESCRIPTION="a compatibility layer for running WindowMaker dockapps on Xfce4."
HOMEPAGE="http://www.ibh.de/~ellguth/xfce4-wmdock-plugin.html"
SRC_URI="http://www.ibh.de/~ellguth/develop/${MY_P}.tar.gz"

KEYWORDS="amd64 x86 ~x86-fbsd"
IUSE="debug"

RDEPEND=">=x11-libs/libwnck-2
	xfce-base/libxfcegui4
	xfce-base/libxfce4util"
DEPEND="${RDEPEND}
	dev-util/intltool"

DOCS="AUTHORS ChangeLog README TODO"

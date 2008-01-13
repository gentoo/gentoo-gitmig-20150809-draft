# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-wmdock/xfce4-wmdock-0.1.8.ebuild,v 1.1 2008/01/13 15:40:58 drac Exp $

inherit autotools xfce44

xfce44_plugin

DESCRIPTION="a compatibility layer for running WindowMaker dockapps on Xfce4."
HOMEPAGE="http://www.ibh.de/~ellguth/xfce4-wmdock-plugin.html"
SRC_URI="http://www.ibh.de/~ellguth/develop/${MY_P}.tar.gz"

KEYWORDS="~amd64"
IUSE="debug"

RDEPEND=">=x11-libs/libwnck-2
	xfce-base/xfce4-panel
	xfce-base/libxfcegui4
	xfce-base/libxfce4util"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool"

DOCS="AUTHORS ChangeLog README TODO"

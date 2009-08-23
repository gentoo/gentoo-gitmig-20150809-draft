# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-wavelan/xfce4-wavelan-0.5.4.ebuild,v 1.13 2009/08/23 21:23:11 ssuominen Exp $

inherit xfce44

xfce44
xfce44_gzipped

DESCRIPTION="Wireless monitor panel plugin"
KEYWORDS="amd64 arm hppa ppc ppc64 x86"
IUSE="debug"

RDEPEND="xfce-base/xfce4-panel"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool"

xfce44_goodies_panel_plugin

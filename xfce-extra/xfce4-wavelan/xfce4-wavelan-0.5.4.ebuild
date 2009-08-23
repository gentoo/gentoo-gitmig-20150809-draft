# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-wavelan/xfce4-wavelan-0.5.4.ebuild,v 1.12 2009/08/23 16:49:18 ssuominen Exp $

inherit xfce44

xfce44
xfce44_gzipped

DESCRIPTION="Wireless monitor panel plugin"
KEYWORDS="amd64 arm hppa ppc ppc64 x86"
IUSE="debug"
DEPEND="dev-util/intltool"

xfce44_goodies_panel_plugin

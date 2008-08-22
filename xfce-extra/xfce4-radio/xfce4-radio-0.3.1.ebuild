# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-radio/xfce4-radio-0.3.1.ebuild,v 1.2 2008/08/22 01:51:59 angelos Exp $

inherit xfce44

xfce44
xfce44_gzipped

DESCRIPTION="Panel plugin to control V4L radio device"
KEYWORDS="amd64 ~x86"
IUSE="debug"

DEPEND="dev-util/pkgconfig
	dev-util/intltool"

DOCS="AUTHORS ChangeLog NEWS README"

xfce44_goodies_panel_plugin

# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-radio/xfce4-radio-0.4.1.ebuild,v 1.1 2009/01/19 18:38:53 angelos Exp $

inherit xfce44

xfce44
xfce44_gzipped

DESCRIPTION="Panel plugin to control V4L radio device"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-util/intltool-0.40"

DOCS="AUTHORS ChangeLog NEWS README"

xfce44_goodies_panel_plugin

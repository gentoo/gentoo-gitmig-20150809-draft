# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-radio/xfce4-radio-0.4.0.ebuild,v 1.1 2008/12/03 19:14:09 angelos Exp $

inherit xfce44

xfce44
xfce44_gzipped

DESCRIPTION="Panel plugin to control V4L radio device"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-util/intltool"

DOCS="AUTHORS ChangeLog NEWS README"

xfce44_goodies_panel_plugin

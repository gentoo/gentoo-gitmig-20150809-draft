# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-radio/xfce4-radio-0.4.2.ebuild,v 1.1 2009/03/18 07:55:52 angelos Exp $

inherit xfce4

xfce4_gzipped

DESCRIPTION="Panel plugin to control V4L radio device"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND=">=dev-util/intltool-0.40"

src_unpack() {
	xfce4_src_unpack
	cd "${S}"
	echo "panel-plugin/radio.desktop.in.in" >>po/POTFILES.skip
	echo "panel-plugin/xfce4-radio.c" >>po/POTFILES.skip
}

DOCS="AUTHORS ChangeLog NEWS README"

xfce4_panel_plugin

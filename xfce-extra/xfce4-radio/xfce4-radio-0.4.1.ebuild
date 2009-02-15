# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-radio/xfce4-radio-0.4.1.ebuild,v 1.2 2009/02/15 18:22:32 angelos Exp $

inherit xfce44

xfce44
xfce44_gzipped

DESCRIPTION="Panel plugin to control V4L radio device"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-util/intltool-0.40"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	echo "panel-plugin/radio.desktop.in.in" >>po/POTFILES.skip
	echo "panel-plugin/xfce4-radio.c" >>po/POTFILES.skip
}

DOCS="AUTHORS ChangeLog NEWS README"

xfce44_goodies_panel_plugin

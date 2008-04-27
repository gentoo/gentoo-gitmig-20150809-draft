# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-mpc/xfce4-mpc-0.3.3.ebuild,v 1.1 2008/04/27 02:07:43 drac Exp $

inherit xfce44

xfce44
xfce44_gzipped

DESCRIPTION="Music Player Daemon (mpd) panel plugin"
KEYWORDS="~amd64 ~x86"
IUSE="debug libmpd"

RDEPEND="libmpd? ( >=media-libs/libmpd-0.15 )"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-perl/XML-Parser"

DOCS="AUTHORS ChangeLog NEWS README TODO"

pkg_setup() {
	XFCE_CONFIG+=" $(use_enable libmpd)"
}

xfce44_goodies_panel_plugin

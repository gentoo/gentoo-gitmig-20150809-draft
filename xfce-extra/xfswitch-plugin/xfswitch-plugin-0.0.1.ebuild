# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfswitch-plugin/xfswitch-plugin-0.0.1.ebuild,v 1.2 2009/09/20 16:26:32 darkside Exp $

EAPI=2
inherit xfconf

DESCRIPTION="User switching plugin for the Xfce4 Panel"
HOMEPAGE="http://goodies.xfce.org/projects/panel-plugins/xfswitch-plugin"
SRC_URI="mirror://xfce/src/panel-plugins/${PN}/0.0/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug"

CDEPEND="x11-libs/gtk+:2
	xfce-base/libxfce4util
	xfce-base/libxfcegui4
	xfce-base/xfce4-panel"
RDEPEND="${CDEPEND}
	gnome-base/gdm"
DEPEND="${CDEPEND}
	dev-util/pkgconfig
	dev-util/intltool"

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README"
	XFCONF="--disable-dependency-tracking
		$(use_enable debug)"
}

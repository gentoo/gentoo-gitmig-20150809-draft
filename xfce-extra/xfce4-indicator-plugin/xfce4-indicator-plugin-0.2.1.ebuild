# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-indicator-plugin/xfce4-indicator-plugin-0.2.1.ebuild,v 1.1 2011/05/07 07:49:34 angelos Exp $

EAPI=4
inherit xfconf

DESCRIPTION="A panel plugin that uses indicator-applet to show new messages"
HOMEPAGE="http://goodies.xfce.org/projects/panel-plugins/xfce4-indicator-plugin"
SRC_URI="mirror://xfce/src/panel-plugins/${PN}/0.2/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-libs/libindicator
	x11-libs/gtk+:2
	xfce-base/libxfce4util
	xfce-base/xfce4-panel"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/gettext"

pkg_setup() {
	XFCONF=( --disable-static $(xfconf_use_debug) )
	DOCS=( AUTHORS ChangeLog NEWS README THANKS )
}

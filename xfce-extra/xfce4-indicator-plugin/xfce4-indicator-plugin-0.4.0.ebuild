# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-indicator-plugin/xfce4-indicator-plugin-0.4.0.ebuild,v 1.2 2011/11/26 16:30:20 ssuominen Exp $

EAPI=4
inherit xfconf

DESCRIPTION="A panel plugin that uses indicator-applet to show new messages"
HOMEPAGE="http://goodies.xfce.org/projects/panel-plugins/xfce4-indicator-plugin"
SRC_URI="mirror://xfce/src/panel-plugins/${PN}/${PV%.*}/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

# note: pull in SLOT="0" for GTK+-2.0 support
RDEPEND=">=dev-libs/libindicator-0.4:0
	x11-libs/gtk+:2
	>=xfce-base/libxfce4util-4.8
	>=xfce-base/xfce4-panel-4.8"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/gettext"

pkg_setup() {
	XFCONF=(
		--disable-static
		$(xfconf_use_debug)
		)

	DOCS=( AUTHORS ChangeLog NEWS README THANKS )
}

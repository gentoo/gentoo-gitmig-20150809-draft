# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-modemlights-plugin/xfce4-modemlights-plugin-0.1.3.99.ebuild,v 1.4 2011/01/29 21:01:57 ssuominen Exp $

EAPI=3
inherit xfconf

DESCRIPTION="a panel plugin to turn dialup (ppp) connections on/off"
HOMEPAGE="http://www.xfce.org/"
SRC_URI="mirror://xfce/src/panel-plugins/${PN}/0.1/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="debug"

RDEPEND=">=dev-libs/glib-2.8:2
	>=x11-libs/gtk+-2.6:2
	>=xfce-base/libxfce4util-4.4
	>=xfce-base/libxfcegui4-4.4
	>=xfce-base/xfce4-panel-4.4"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig"

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README"
	XFCONF=(
		--disable-dependency-tracking
		$(use_enable debug)
		)
}

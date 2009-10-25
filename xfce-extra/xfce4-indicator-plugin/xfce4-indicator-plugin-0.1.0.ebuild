# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-indicator-plugin/xfce4-indicator-plugin-0.1.0.ebuild,v 1.2 2009/10/25 13:50:30 ssuominen Exp $

EAPI=2
inherit xfconf

DESCRIPTION="a panel plugin that uses indicator-applet to show new messages"
HOMEPAGE="http://www.xfce.org/"
SRC_URI="mirror://xfce/src/panel-plugins/${PN}/0.1/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug"

RDEPEND=">=x11-libs/gtk+-2.6:2
	>=xfce-base/libxfcegui4-4.3.99.2
	>=xfce-base/libxfce4util-4.3.99.2
	>=xfce-base/xfce4-panel-4.3.99.2
	>=dev-libs/libindicator-0.2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

pkg_setup() {
	XFCONF="--disable-dependency-tracking
		$(use_enable debug)"
	DOCS="AUTHORS ChangeLog NEWS README THANKS"
}

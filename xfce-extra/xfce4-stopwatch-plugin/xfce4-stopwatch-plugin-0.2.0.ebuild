# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-stopwatch-plugin/xfce4-stopwatch-plugin-0.2.0.ebuild,v 1.3 2009/10/02 11:50:25 ssuominen Exp $

EAPI=2
inherit xfconf

DESCRIPTION="panel plugin that keeps track of elapsed time"
HOMEPAGE="http://goodies.xfce.org/projects/panel-plugins/xfce4-stopwatch-plugin"
SRC_URI="mirror://xfce/src/panel-plugins/${PN}/0.2/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug"

RDEPEND=">=x11-libs/gtk+-2.10:2
	>=xfce-base/libxfce4util-4.6
	>=xfce-base/libxfcegui4-4.6
	>=xfce-base/xfce4-panel-4.6"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool"

pkg_setup() {
	XFCONF="--disable-dependency-tracking
		$(use_enable debug)"
	DOCS="AUTHORS NEWS"
}

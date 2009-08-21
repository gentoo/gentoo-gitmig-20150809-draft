# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-stopwatch-plugin/xfce4-stopwatch-plugin-0.2.0.ebuild,v 1.1 2009/08/21 20:22:55 darkside Exp $

EINTLTOOLIZE="yes"
EAUTORECONF="yes"

inherit xfconf

DESCRIPTION="panel plugin that keeps track of elapsed time"
HOMEPAGE="http://goodies.xfce.org/projects/panel-plugins/xfce4-stopwatch-plugin"
SRC_URI="http://archive.xfce.org/src/panel-plugins/${PN}/0.2/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug nls"

RDEPEND=">=xfce-base/xfce4-panel-4.6.1"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

pkg_setup() {
	XFCONF="--disable-dependency-tracking
		$(use_enable debug) $(use_enable nls)"
	DOCS="AUTHORS ChangeLog NEWS README"
}

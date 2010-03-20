# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-radio-plugin/xfce4-radio-plugin-0.4.2.ebuild,v 1.5 2010/03/20 17:43:58 ssuominen Exp $

EAPI=2
inherit xfconf

DESCRIPTION="Panel plugin to control V4L radio device"
HOMEPAGE="http://goodies.xfce.org/projects/panel-plugins/xfce4-radio-plugin"
SRC_URI="mirror://xfce/src/panel-plugins/${PN}/0.4/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug"

RDEPEND=">=xfce-base/xfce4-panel-4.3.22"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.40"

pkg_setup() {
	XFCONF="--disable-dependency-tracking
		$(use_enable debug)"
	DOCS="AUTHORS ChangeLog NEWS README"
}

src_prepare() {
	xfconf_src_prepare
	echo panel-plugin/radio.desktop.in.in >> po/POTFILES.skip
	echo panel-plugin/xfce4-radio.c >> po/POTFILES.skip
}

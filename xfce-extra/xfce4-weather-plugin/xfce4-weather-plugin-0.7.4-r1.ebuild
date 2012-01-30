# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-weather-plugin/xfce4-weather-plugin-0.7.4-r1.ebuild,v 1.2 2012/01/30 16:51:07 ago Exp $

EAPI=4
inherit xfconf

DESCRIPTION="A weather plug-in for the Xfce desktop environment"
HOMEPAGE="http://goodies.xfce.org/projects/panel-plugins/xfce4-weather-plugin"
SRC_URI="mirror://xfce/src/panel-plugins/${PN}/0.7/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="debug"

RDEPEND=">=x11-libs/gtk+-2.6:2
	>=xfce-base/libxfce4util-4.8
	>=xfce-base/libxfcegui4-4.8
	>=xfce-base/xfce4-panel-4.8
	>=dev-libs/libxml2-2.4"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig"

pkg_setup() {
	XFCONF=( $(xfconf_use_debug) )
	DOCS=( AUTHORS ChangeLog NEWS README TODO )
}

src_prepare() {
	# http://bugzilla.xfce.org/show_bug.cgi?id=8105#c9
	sed -i \
		-e '/PARTNER_ID/s:1121946239:1003666583:' \
		-e '/LICENSE_KEY/s:3c4cd39ee5dec84f:4128909340a9b2fc:' \
		panel-plugin/weather.h || die

	xfconf_src_prepare
}

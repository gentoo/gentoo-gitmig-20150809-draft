# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-weather/xfce4-weather-0.6.4.ebuild,v 1.8 2009/08/23 16:47:30 ssuominen Exp $

inherit autotools xfce4

xfce4_panel_plugin

DESCRIPTION="Weather monitor panel plugin"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

DOCS="AUTHORS ChangeLog NEWS README TODO"

RDEPEND=">=xfce-base/xfce4-panel-4.3.99.1"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/xfce4-dev-tools"

src_unpack() {
	unpack ${A}
	cd "${S}"
	intltoolize --force --copy --automake || die "intltoolize failed"
	AT_M4DIR="/usr/share/xfce4/dev-tools/m4macros" eautoreconf
}

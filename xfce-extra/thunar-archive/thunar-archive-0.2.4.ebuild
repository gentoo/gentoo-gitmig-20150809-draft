# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/thunar-archive/thunar-archive-0.2.4.ebuild,v 1.1 2007/01/22 01:00:13 nichoj Exp $

inherit gnome2 xfce44

xfce44_beta
xfce44_goodies_thunar_plugin

MY_P="${PN}-plugin-${PV}"
DESCRIPTION="Thunar archive plugin"
HOMEPAGE="http://www.foo-projects.org/~benny/projects/thunar-archive-plugin/"
SRC_URI="http://download.berlios.de/xfce-goodies/${MY_P}${COMPRESS}"

KEYWORDS="~x86"

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}

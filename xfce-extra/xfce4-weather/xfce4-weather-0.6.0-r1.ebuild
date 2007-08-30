# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-weather/xfce4-weather-0.6.0-r1.ebuild,v 1.5 2007/08/30 03:27:11 jer Exp $

inherit eutils xfce44

xfce44
xfce44_goodies_panel_plugin

RESTRICT="test"

DESCRIPTION="Weather monitor panel plugin"
KEYWORDS="alpha amd64 ~arm hppa ia64 ~mips ~ppc ~ppc64 sparc x86 ~x86-fbsd"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-freebsd.patch"
}

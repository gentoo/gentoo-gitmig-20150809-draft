# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-battery/xfce4-battery-0.5.0-r2.ebuild,v 1.6 2007/06/08 19:34:44 drac Exp $

inherit eutils xfce44

xfce44

RESTRICT="test"

DESCRIPTION="Battery status panel plugin"
KEYWORDS="amd64 arm ppc ppc64 x86 ~x86-fbsd"
IUSE="debug"

DEPEND="dev-util/pkgconfig
	dev-util/intltool"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-freebsd.patch
	epatch "${FILESDIR}"/${P}-libacpi.patch
	epatch "${FILESDIR}"/${P}-2.6.21.patch
}

DOCS="AUTHORS ChangeLog NEWS README"

xfce44_goodies_panel_plugin

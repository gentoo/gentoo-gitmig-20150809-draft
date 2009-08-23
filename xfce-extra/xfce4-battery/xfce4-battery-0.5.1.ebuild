# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-battery/xfce4-battery-0.5.1.ebuild,v 1.7 2009/08/23 21:21:42 ssuominen Exp $

inherit eutils xfce44

xfce44

DESCRIPTION="Battery status panel plugin"
KEYWORDS="amd64 arm ppc x86 ~x86-fbsd"
IUSE="debug"

RDEPEND="xfce-base/xfce4-panel"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-freebsd.patch \
		"${FILESDIR}"/${PN}-0.5.0-libacpi.patch \
		"${FILESDIR}"/${PN}-0.5.0-2.6.24-headers.patch \
		"${FILESDIR}"/${PN}-0.5.0-sysfs.patch
}

DOCS="AUTHORS ChangeLog NEWS README"

xfce44_goodies_panel_plugin

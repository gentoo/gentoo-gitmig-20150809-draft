# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-battery/xfce4-battery-0.5.0-r2.ebuild,v 1.11 2008/08/24 13:40:39 corsair Exp $

inherit autotools eutils xfce44

xfce44

DESCRIPTION="Battery status panel plugin"
KEYWORDS="amd64 arm ppc x86 ~x86-fbsd"
IUSE="debug"

DEPEND="dev-util/pkgconfig
	dev-util/intltool
	dev-util/xfce4-dev-tools"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-freebsd.patch \
		"${FILESDIR}"/${P}-libacpi.patch \
		"${FILESDIR}"/${P}-2.6.21.patch \
		"${FILESDIR}"/${P}-2.6.24-headers.patch

	sed -i -e "/^AC_INIT/s/battery_version()/battery_version/" configure.in
	intltoolize --force --copy --automake || die "intltoolize failed."
	AT_M4DIR=/usr/share/xfce4/dev-tools/m4macros eautoreconf
}

DOCS="AUTHORS ChangeLog NEWS README"

xfce44_goodies_panel_plugin

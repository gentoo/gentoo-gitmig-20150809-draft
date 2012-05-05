# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/mousetweaks/mousetweaks-3.2.1-r10.ebuild,v 1.2 2012/05/05 06:25:17 jdhore Exp $

EAPI="4"
GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="Mouse accessibility enhancements for the GNOME desktop"
HOMEPAGE="http://live.gnome.org/Mousetweaks/Home"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="" # appet

RDEPEND="
	>=dev-libs/glib-2.25.9:2
	>=x11-libs/gtk+-3:3
	>=gnome-base/gsettings-desktop-schemas-0.1

	x11-libs/libX11
	x11-libs/libXtst
	x11-libs/libXfixes
	x11-libs/libXcursor"
#	applet? (
#		>=gnome-base/gnome-panel-2.32
#		<gnome-base/gnome-panel-2.90 )
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.40
	virtual/pkgconfig"
# eautoreconf needs:
#	gnome-base/gnome-common

pkg_setup() {
	DOCS="AUTHORS ChangeLog MAINTAINERS NEWS README"
	# Disable pointer-capture, dwell-click applets: they require gnome-panel-2
	G2CONF="${G2CONF}
		--disable-schemas-compile
		--disable-pointer-capture
		--disable-dwell-click"
#		$(use_enable applet pointer-capture)
#		$(use_enable applet dwell-click)
}

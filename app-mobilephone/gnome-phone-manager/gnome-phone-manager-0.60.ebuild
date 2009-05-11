# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/gnome-phone-manager/gnome-phone-manager-0.60.ebuild,v 1.4 2009/05/11 19:29:08 fauli Exp $

EAPI="2"

inherit gnome2

DESCRIPTION="a program created to allow you to control aspects of your mobile phone from your GNOME 2 desktop"
HOMEPAGE="http://live.gnome.org/PhoneManager"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""
# telepathy support is considered experimental

RDEPEND=">=x11-libs/gtk+-2.10
	>=gnome-base/gconf-2
	dev-libs/glib:2
	>=media-libs/gstreamer-0.10
	>=gnome-base/orbit-2
	dev-libs/openobex
	>=app-mobilephone/gnokii-0.6.26[bluetooth]
	|| ( >=net-wireless/bluez-libs-3.12 net-wireless/bluez )
	>=gnome-base/libglade-2
	>=gnome-extra/evolution-data-server-1.2.3
	net-wireless/gnome-bluetooth
	dev-libs/dbus-glib
	>=x11-themes/gnome-icon-theme-2.19.1
	>=app-text/gtkspell-2"

DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig"

DOCS="README NEWS AUTHORS ChangeLog"

pkg_setup() {
	G2CONF="${G2CONF} --disable-telepathy"
}

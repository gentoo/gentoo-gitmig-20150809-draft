# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/gnome-phone-manager/gnome-phone-manager-0.65.ebuild,v 1.4 2010/06/26 15:10:17 nixnut Exp $

EAPI="2"

inherit gnome2

DESCRIPTION="a program created to allow you to control aspects of your mobile phone from your GNOME 2 desktop"
HOMEPAGE="http://live.gnome.org/PhoneManager"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~x86"
IUSE=""
# telepathy support is considered experimental

RDEPEND="dev-libs/glib:2
	>=x11-libs/gtk+-2.10
	>=gnome-base/orbit-2
	>=gnome-base/gconf-2
	>=gnome-base/libglade-2
	>=gnome-extra/evolution-data-server-1.2.3
	media-libs/libcanberra[gtk]
	>=app-mobilephone/gnokii-0.6.27[bluetooth]
	net-wireless/bluez
	dev-libs/dbus-glib
	dev-libs/openobex
	>=net-wireless/gnome-bluetooth-2.27
	media-libs/libcanberra[gtk]
	>=x11-themes/gnome-icon-theme-2.19.1
	>=app-text/gtkspell-2"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35.5
	dev-util/pkgconfig"
# gnome-common needed for eautoreconf

DOCS="README NEWS AUTHORS ChangeLog"

pkg_setup() {
	G2CONF="${G2CONF} --disable-telepathy"
}

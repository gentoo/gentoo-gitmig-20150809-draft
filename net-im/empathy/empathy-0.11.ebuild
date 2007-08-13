# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/empathy/empathy-0.11.ebuild,v 1.1 2007/08/13 15:34:18 coldwind Exp $

inherit gnome2

DESCRIPTION="Empathy Telepathy client"
HOMEPAGE="http://live.gnome.org/Empathy"
SRC_URI="http://ftp.gnome.org/pub/GNOME/sources/${PN}/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="spell"

RDEPEND=">=dev-libs/dbus-glib-0.51
	>=dev-libs/glib-2.12
	dev-libs/libxml2
	>=gnome-base/gconf-2
	>=gnome-base/libglade-2
	gnome-base/libgnomeui
	>=net-libs/libtelepathy-0.0.51
	>=net-im/telepathy-mission-control-4.33
	>=x11-libs/gtk+-2.10
	spell? ( app-text/aspell )"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0"

DOCS="CONTRIBUTORS AUTHORS README"

pkg_setup() {
	G2CONF="$(use_enable spell aspell)"
}

pkg_postinst() {
	gnome2_pkg_postinst
	echo
	elog "Empathy needs telepathy's connection managers to use any protocol."
	elog "You'll need to install connection managers yourself."
	elog "MSN: net-voip/telepathy-butterfly"
	elog "Jabber and Gtalk: net-voip/telepathy-gabble"
	elog "IRC: net-irc/telepathy-idle"
}

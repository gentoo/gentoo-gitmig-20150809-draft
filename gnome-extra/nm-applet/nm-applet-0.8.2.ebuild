# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/nm-applet/nm-applet-0.8.2.ebuild,v 1.4 2011/02/05 12:20:10 ssuominen Exp $

EAPI=2
inherit eutils gnome2

MY_PN="${PN/nm-applet/network-manager-applet}"

DESCRIPTION="Gnome applet for NetworkManager."
HOMEPAGE="http://projects.gnome.org/NetworkManager/"
SRC_URI="${SRC_URI//${PN}/${MY_PN}}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="bluetooth"

# FIXME: bluetooth is automagic
RDEPEND=">=dev-libs/glib-2.16
	>=dev-libs/dbus-glib-0.88
	>=sys-apps/dbus-1.4.1
	>=x11-libs/gtk+-2.18
	>=gnome-base/gconf-2.20
	>=x11-libs/libnotify-0.4.3
	>=gnome-base/libglade-2
	>=gnome-base/gnome-keyring-2.20

	>=dev-libs/libnl-1.1
	>=net-misc/networkmanager-${PV}
	>=net-wireless/wireless-tools-28_pre9
	>=net-wireless/wpa_supplicant-0.5.7
	net-misc/mobile-broadband-provider-info
	bluetooth? ( >=net-wireless/gnome-bluetooth-2.27.6 )
	>=sys-auth/polkit-0.96-r1"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.35"

S=${WORKDIR}/${MY_PN}-${PV}

pkg_setup () {
	G2CONF="${G2CONF}
		--disable-more-warnings
		--localstatedir=/var"

	DOCS="AUTHORS ChangeLog NEWS README"
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-libnotify-0.7.patch
	gnome2_src_prepare
}

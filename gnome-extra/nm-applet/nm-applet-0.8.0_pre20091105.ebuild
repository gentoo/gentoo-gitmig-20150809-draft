# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/nm-applet/nm-applet-0.8.0_pre20091105.ebuild,v 1.1 2009/11/05 14:33:36 dagger Exp $

EAPI=2
inherit gnome2 eutils versionator

MY_P="${P/nm-applet/network-manager-applet}"
MYPV_MINOR=$(get_version_component_range)

DESCRIPTION="Gnome applet for NetworkManager."
HOMEPAGE="http://projects.gnome.org/NetworkManager/"
SRC_URI="http://dev.gentoo.org/~dagger/files/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""
#IUSE="bluetooth"

RDEPEND=">=sys-apps/dbus-1.2
	>=dev-libs/libnl-1.1
	>=net-misc/networkmanager-${MYPV_MINOR}
	>=net-wireless/wireless-tools-28_pre9
	>=net-wireless/wpa_supplicant-0.5.7
	>=dev-libs/glib-2.16
	>=x11-libs/libnotify-0.4.3
	>=x11-libs/gtk+-2.14
	>=dev-libs/dbus-glib-0.74
	>=gnome-base/libglade-2
	>=gnome-base/gnome-keyring-2.20
	|| ( >=gnome-base/gnome-panel-2 xfce-base/xfce4-panel x11-misc/trayer )
	>=gnome-base/gconf-2.20
	>=gnome-extra/polkit-gnome-0.92
	net-misc/mobile-broadband-provider-info"
#bluetooth? ( >=net-wireless/gnome-bluetooth-2.27.7
#>=net-wireless/bluez-4.42 )

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.35"

DOCS="AUTHORS ChangeLog NEWS README"
# USE_DESTDIR="1"

S=${WORKDIR}/${MY_P}

pkg_setup () {
	G2CONF="${G2CONF} \
		--disable-more-warnings \
		--localstatedir=/var \
		--with-dbus-sys=/etc/dbus-1/system.d"
}

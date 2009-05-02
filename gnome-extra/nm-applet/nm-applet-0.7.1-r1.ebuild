# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/nm-applet/nm-applet-0.7.1-r1.ebuild,v 1.1 2009/05/02 18:57:48 dang Exp $

EAPI=2
inherit gnome2 eutils versionator

MY_P="${P/nm-applet/network-manager-applet}"
MYPV_MINOR=$(get_version_component_range 1-2)

DESCRIPTION="Gnome applet for NetworkManager."
HOMEPAGE="http://projects.gnome.org/NetworkManager/"
SRC_URI="mirror://gnome/sources/network-manager-applet/0.7/${MY_P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~x86"
IUSE=""

RDEPEND=">=sys-apps/dbus-1.2
	>=sys-apps/hal-0.5.9
	>=dev-libs/libnl-1.1
	=net-misc/networkmanager-${MYPV_MINOR}*
	>=net-wireless/wireless-tools-28_pre9
	>=net-wireless/wpa_supplicant-0.5.7
	>=dev-libs/glib-2.16
	>=x11-libs/libnotify-0.4.3
	>=x11-libs/gtk+-2.10
	>=gnome-base/libglade-2
	>=gnome-base/gnome-keyring-2.20
	|| ( >=gnome-base/gnome-panel-2 xfce-base/xfce4-panel x11-misc/trayer )
	>=gnome-base/gconf-2.20
	>=gnome-extra/policykit-gnome-0.8"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.35"

DOCS="AUTHORS COPYING ChangeLog INSTALL NEWS README"
# USE_DESTDIR="1"

S=${WORKDIR}/${MY_P}

pkg_setup () {
	G2CONF="${G2CONF} \
		--disable-more-warnings \
		--localstatedir=/var \
		--with-dbus-sys=/etc/dbus-1/system.d"
}

src_prepare() {
	epatch "${FILESDIR}/${P}-confchanges.patch"
}

pkg_postinst() {
	gnome2_pkg_postinst
	elog "Your user needs to be in the plugdev group in order to use this"
	elog "package.  If it doesn't start in Gnome for you automatically after"
	elog 'you log back in, simply run "nm-applet --sm-disable"'
	elog "You also need the notification area applet on your panel for"
	elog "this to show up."
}

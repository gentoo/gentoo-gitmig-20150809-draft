# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/bluez-gnome/bluez-gnome-1.8.ebuild,v 1.1 2008/11/28 21:32:13 dev-zero Exp $

inherit gnome2

DESCRIPTION="Bluetooth helpers for GNOME"
HOMEPAGE="http://www.bluez.org/"
SRC_URI="mirror://kernel/linux/bluetooth/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~sparc ~x86"

IUSE="gnome"
COMMON_DEPEND=">=dev-libs/glib-2.0
	>=x11-libs/libnotify-0.3.2
	>=gnome-base/gconf-2.6
	>=dev-libs/dbus-glib-0.60
	sys-apps/hal
	>=x11-libs/gtk+-2.6"
DEPEND="
	dev-util/pkgconfig
	x11-proto/xproto
	${COMMON_DEPEND}"
RDEPEND="net-wireless/bluez
	gnome? ( gnome-base/nautilus )
	>=app-mobilephone/obex-data-server-0.4
	${COMMON_DEPEND}"

PDEPEND="gnome? ( gnome-extra/gnome-vfs-obexftp )"

G2CONF="--disable-desktop-update
		--disable-mime-update
		--disable-icon-update"

DOCS="AUTHORS README NEWS ChangeLog"

pkg_postinst() {
	gnome2_pkg_postinst
	if has_version gnome-base/nautilus && \
		! has_version gnome-extra/gnome-vfs-obexftp; then
		ewarn "You have nautilus installed so Browse Device functionality is"
		ewarn "enabled but gives you an obex:// not being a valid location"
		ewarn "error until you install gnome-extra/gnome-vfs-obexftp. You"
		ewarn "can do this by turning on the gnome use flag for ${PN}."
	fi
}

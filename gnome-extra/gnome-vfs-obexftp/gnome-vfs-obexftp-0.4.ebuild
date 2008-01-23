# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-vfs-obexftp/gnome-vfs-obexftp-0.4.ebuild,v 1.3 2008/01/23 19:23:12 maekke Exp $

GCONF_DEBUG=no

inherit gnome2

DESCRIPTION="OBEX FTP Client for GNOME-VFS"
HOMEPAGE="http://www.gnome.org"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=gnome-base/gnome-vfs-2.12.0.1
	dev-libs/dbus-glib
	>=dev-libs/openobex-1.2
	>=net-wireless/bluez-libs-3.7
	>=net-wireless/bluez-utils-3.7
	net-wireless/bluez-gnome"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

G2CONF="${G2CONF} --enable-nautilus-workaround"
DOCS="AUTHORS ChangeLog NEWS README* docs/*.txt"

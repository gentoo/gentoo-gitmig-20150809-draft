# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/bluez-gnome/bluez-gnome-0.13.ebuild,v 1.1 2007/08/12 09:59:39 betelgeuse Exp $

inherit gnome2

DESCRIPTION="Bluetooth helpers for GNOME"
HOMEPAGE="http://www.bluez.org/"
SRC_URI="http://bluez.sourceforge.net/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

IUSE=""
DEPEND=">=dev-libs/glib-2.0
	>=x11-libs/libnotify-0.3.2
	>=gnome-base/gconf-2.6
	>=dev-libs/dbus-glib-0.60
	sys-apps/hal
	x11-proto/xproto
	>=x11-libs/gtk+-2.6"
RDEPEND="=net-wireless/bluez-utils-3*
	${DEPEND}"

DOCS="AUTHORS README NEWS ChangeLog"

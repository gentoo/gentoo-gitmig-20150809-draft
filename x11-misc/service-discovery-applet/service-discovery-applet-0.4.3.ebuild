# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/service-discovery-applet/service-discovery-applet-0.4.3.ebuild,v 1.7 2009/01/06 20:54:45 swegener Exp $

inherit eutils gnome2

DESCRIPTION="Service Discovery Applet"
HOMEPAGE="http://0pointer.de/~sebest/"
SRC_URI="http://0pointer.de/~sebest/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/python-2.4
	>=dev-python/gnome-python-desktop-2.14.0
	>=dev-python/pygtk-2.0
	gnome-base/gconf
	dev-python/dbus-python
	net-dns/avahi"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.21"

pkg_setup() {
	if ! built_with_use net-dns/avahi python || ! ( has_version dev-python/dbus-python || built_with_use sys-apps/dbus python )
	then
		die "Sorry, but you need net-dns/avahi and sys-apps/dbus compiled with python support."
	fi

	if ! built_with_use net-dns/avahi gdbm
	then
		die "Sorry, but you need net-dns/avahi compiled with gdbm support."
	fi

	G2CONF="${G2CONF} --disable-schemas-install"
}

src_install() {
	USE_DESTDIR="1" gnome2_src_install
	dodoc AUTHORS README
}

# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/service-discovery-applet/service-discovery-applet-0.1.ebuild,v 1.1 2005/09/26 12:22:22 swegener Exp $

inherit eutils gnome2

DESCRIPTION="Service Discovery Applet"
HOMEPAGE="none"
SRC_URI="http://0pointer.de/public/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="net-dns/avahi
	>=dev-lang/python-2.4
	dev-python/gnome-python-extras
	gnome-base/gconf
	>=dev-python/pygtk-2.0
	sys-apps/dbus"
RDEPEND="${DEPEND}"

pkg_setup() {
	if ! built_with_use net-dns/avahi python || ! built_with_use sys-apps/dbus python
	then
		die "Sorry, but you need net-dns/avahi and sys-apps/dbus compiled with python support."
	fi
}

src_install() {
	USE_DESTDIR="1" gnome2_src_install
	dodoc AUTHORS README
}

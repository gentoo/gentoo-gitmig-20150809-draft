# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/service-discovery-applet/service-discovery-applet-0.4.3-r1.ebuild,v 1.3 2010/07/22 11:25:40 ssuominen Exp $

EAPI=2
inherit gnome2

DESCRIPTION="Service Discovery Applet"
HOMEPAGE="http://0pointer.de/~sebest/"
SRC_URI="http://0pointer.de/~sebest/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/python-2.4
	dev-python/libgnome-python
	dev-python/gconf-python
	dev-python/gnome-applets-python
	>=dev-python/pygtk-2.0
	gnome-base/gconf
	dev-python/dbus-python
	net-dns/avahi[gdbm,python]"
DEPEND="${RDEPEND}
	dev-util/intltool"

pkg_setup() {
	DOCS="AUTHORS README"
	G2CONF="${G2CONF} --disable-schemas-install"
}

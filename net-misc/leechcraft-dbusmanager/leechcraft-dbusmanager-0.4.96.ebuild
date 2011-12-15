# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/leechcraft-dbusmanager/leechcraft-dbusmanager-0.4.96.ebuild,v 1.1 2011/12/15 19:38:56 maksbotan Exp $

EAPI="2"

inherit leechcraft

DESCRIPTION="DBusManager provides some basic D-Bus interoperability for LeechCraft."

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="=net-misc/leechcraft-core-${PV}
		x11-libs/qt-dbus"
RDEPEND="${DEPEND}"

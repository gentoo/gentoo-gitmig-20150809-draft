# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/leechcraft-dbusmanager/leechcraft-dbusmanager-9999.ebuild,v 1.2 2011/12/16 18:41:33 maksbotan Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="DBusManager provides some basic D-Bus interoperability for LeechCraft."

SLOT="0"
KEYWORDS=""
IUSE="debug"

DEPEND="~net-misc/leechcraft-core-${PV}
		x11-libs/qt-dbus"
RDEPEND="${DEPEND}"

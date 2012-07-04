# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/leechcraft-dbusmanager/leechcraft-dbusmanager-0.5.70.ebuild,v 1.2 2012/07/04 21:09:42 ago Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="DBusManager provides some basic D-Bus interoperability for LeechCraft."

SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="debug"

DEPEND="~net-misc/leechcraft-core-${PV}
		x11-libs/qt-dbus"
RDEPEND="${DEPEND}"

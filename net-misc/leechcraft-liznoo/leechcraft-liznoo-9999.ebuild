# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/leechcraft-liznoo/leechcraft-liznoo-9999.ebuild,v 1.2 2011/12/16 18:44:17 maksbotan Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="UPower-based power manager for LeechCraft"

SLOT="0"
KEYWORDS=""
IUSE="debug"

DEPEND="=net-misc/leechcraft-core-${PV}
	sys-power/upower
	x11-libs/qwt:6
	x11-libs/qt-dbus
	virtual/leechcraft-trayarea"
RDEPEND="${DEPEND}"

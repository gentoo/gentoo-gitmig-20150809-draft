# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/leechcraft-liznoo/leechcraft-liznoo-9999.ebuild,v 1.1 2011/12/15 19:41:39 maksbotan Exp $

EAPI="2"

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

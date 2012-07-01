# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/leechcraft-vrooby/leechcraft-vrooby-9999.ebuild,v 1.1 2012/07/01 13:36:56 maksbotan Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="Vrooby, removable device manager for LeechCraft."

SLOT="0"
KEYWORDS=""
IUSE="debug"

DEPEND="~net-misc/leechcraft-core-${PV}
		x11-libs/qt-dbus"
RDEPEND="${DEPEND}
		sys-fs/udisks:0"

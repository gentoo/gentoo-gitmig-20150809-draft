# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/leechcraft-lemon/leechcraft-lemon-9999.ebuild,v 1.2 2012/12/20 13:50:20 maksbotan Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="Network monitor plugin for LeechCraft"

SLOT="0"
KEYWORDS=""
IUSE="debug"

DEPEND="~net-misc/leechcraft-core-${PV}
	~virtual/leechcraft-quark-sideprovider-${PV}
	dev-libs/qt-bearer:4
	x11-libs/qt-declarative:4
	dev-libs/libnl:3
	x11-libs/qwt:6
	"
RDEPEND="${DEPEND}"

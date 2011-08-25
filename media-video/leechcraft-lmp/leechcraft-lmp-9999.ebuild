# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/leechcraft-lmp/leechcraft-lmp-9999.ebuild,v 1.1 2011/08/25 19:58:12 maksbotan Exp $

EAPI="2"

inherit leechcraft

DESCRIPTION="LeechCraft Media Player, Phonon-based audio/video player."

SLOT="0"
KEYWORDS=""
IUSE="debug kde"

DEPEND="=net-misc/leechcraft-core-${PV}
		kde? ( media-libs/phonon )
		!kde? ( x11-libs/qt-phonon )"
RDEPEND="${DEPEND}"

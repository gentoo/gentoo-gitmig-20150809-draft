# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/leechcraft-lmp/leechcraft-lmp-9999.ebuild,v 1.3 2012/06/18 17:19:40 maksbotan Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="LeechCraft Media Player, Phonon-based audio/video player."

SLOT="0"
KEYWORDS=""
IUSE="debug kde +mpris"

DEPEND="~net-misc/leechcraft-core-${PV}
		kde? ( media-libs/phonon )
		!kde? ( x11-libs/qt-phonon )
		media-libs/taglib
		mpris? ( x11-libs/qt-dbus )"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs="$(cmake-utils_use_enable mpris LMP_MPRIS)"
	cmake-utils_src_configure
}

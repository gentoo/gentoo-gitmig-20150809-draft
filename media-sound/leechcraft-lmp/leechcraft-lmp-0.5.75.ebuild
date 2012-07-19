# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/leechcraft-lmp/leechcraft-lmp-0.5.75.ebuild,v 1.1 2012/07/19 19:55:30 maksbotan Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="LeechCraft Media Player, Phonon-based audio/video player."

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug kde +mpris"

DEPEND="~net-misc/leechcraft-core-${PV}
		kde? ( media-libs/phonon )
		!kde? ( x11-libs/qt-phonon:4 )
		media-libs/taglib
		mpris? ( x11-libs/qt-dbus:4 )
		x11-libs/qt-declarative:4"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs="$(cmake-utils_use_enable mpris LMP_MPRIS)"
	cmake-utils_src_configure
}

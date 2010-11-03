# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/granatier/granatier-4.5.3.ebuild,v 1.1 2010/11/03 16:30:54 scarabeus Exp $

EAPI="3"

KDE_HANDBOOK="optional"
KMNAME="kdegames"
inherit kde4-meta

DESCRIPTION="KDE Bomberman game"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug gluon"

DEPEND="
	gluon? ( media-libs/gluon )
"
RDEPEND="${DEPEND}"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use gluon GRANATIER_USE_GLUON_SOUND_BACKEND)
	)

	kde4-meta_src_configure
}

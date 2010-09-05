# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/granatier/granatier-4.5.1.ebuild,v 1.2 2010/09/05 23:16:54 tampakrap Exp $

EAPI="3"

KDE_HANDBOOK=1
KMNAME="kdegames"
inherit kde4-meta

DESCRIPTION="KDE Bomberman game"
KEYWORDS=""
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

# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/smokekde/smokekde-4.7.4.ebuild,v 1.2 2012/01/09 17:50:43 phajdan.jr Exp $

EAPI=4

KDE_SCM="git"

inherit kde4-base

DESCRIPTION="Scripting Meta Object Kompiler Engine - KDE bindings"
KEYWORDS="~amd64 x86"
IUSE="akonadi attica debug kate okular semantic-desktop"

DEPEND="
	$(add_kdebase_dep kdelibs 'semantic-desktop=')
	$(add_kdebase_dep smokeqt)
	akonadi? ( $(add_kdebase_dep kdepimlibs) )
	attica? ( dev-libs/libattica )
	kate? ( $(add_kdebase_dep kate) )
	okular? ( $(add_kdebase_dep okular) )
"
RDEPEND="${DEPEND}"

add_blocker smoke

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with akonadi)
		$(cmake-utils_use_with akonadi KdepimLibs)
		$(cmake-utils_use_with attica LibAttica)
		$(cmake-utils_use_disable kate)
		$(cmake-utils_use_with okular)
		$(cmake-utils_use_with semantic-desktop Nepomuk)
		$(cmake-utils_use_with semantic-desktop Soprano)
	)
	kde4-base_src_configure
}

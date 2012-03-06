# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kig/kig-4.8.1.ebuild,v 1.1 2012/03/06 23:35:11 dilfridge Exp $

EAPI=4

KDE_HANDBOOK="optional"
KDE_SCM="git"
inherit kde4-base

DESCRIPTION="KDE Interactive Geometry tool"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug kig-scripting"

DEPEND="
	kig-scripting? ( >=dev-libs/boost-1.32 )
"
RDEPEND="${DEPEND}"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with kig-scripting BoostPython)
	)

	kde4-base_src_configure
}

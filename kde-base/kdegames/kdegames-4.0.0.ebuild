# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdegames/kdegames-4.0.0.ebuild,v 1.3 2008/01/27 21:41:36 zlin Exp $

EAPI="1"

inherit kde4-base

DESCRIPTION="KDE games module"
HOMEPAGE="http://www.kde.org/"

KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook opengl"
LICENSE="GPL-2 LGPL-2"

DEPEND="opengl? ( virtual/opengl )"
RDEPEND="${DEPEND}"

RESTRICT="test"

PATCHES="${FILESDIR}/lskat-4.0.0-link.patch"

src_compile() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with opengl OpenGL)"

	kde4-base_src_compile
}

# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork/kdeartwork-4.0.0.ebuild,v 1.1 2008/01/17 23:40:35 philantrop Exp $

EAPI="1"

inherit kde4-base

DESCRIPTION="KDE artwork module"
HOMEPAGE="http://www.kde.org/"

KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook opengl xscreensaver" 
LICENSE="GPL-2 LGPL-2"

RESTRICT="binchecks strip"

DEPEND="${DEPEND}
	|| ( >=kde-base/kdebase-${PV}:${SLOT}
		>=kde-base/kscreensaver-${PV}:${SLOT} )
	media-libs/libart_lgpl
	opengl? ( virtual/opengl )
	xscreensaver? ( x11-misc/xscreensaver )"
RDEPEND="${DEPEND}"

pkg_setup() {
	if use opengl; then
		if has_version kde-base/kscreensaver:${SLOT}; then
			KDE4_BUILT_WITH_USE_CHECK="
				kde-base/kscreensaver:${SLOT} opengl"
		else
			KDE4_BUILT_WITH_USE_CHECK="
				kde-base/kdebase:${SLOT} opengl"
		fi
	fi

	kde4-base_pkg_setup
}

src_compile() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with opengl OpenGL)
			$(cmake-utils_use_with xscreensaver Xscreensaver)"

	kde4-base_src_compile
}

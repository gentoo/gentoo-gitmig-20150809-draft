# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork-kscreensaver/kdeartwork-kscreensaver-4.0.1.ebuild,v 1.1 2008/02/07 00:12:59 philantrop Exp $

EAPI="1"

KMMODULE=kscreensaver
KMNAME=kdeartwork
inherit eutils kde4-meta

DESCRIPTION="Extra screensavers for kde"
KEYWORDS="~amd64 ~x86"
IUSE="debug opengl xscreensaver"

DEPEND="${DEPEND}
	|| ( >=kde-base/kscreensaver-${PV}:${SLOT}
		>=kde-base/kdebase-${PV}:${SLOT} )
	media-libs/libart_lgpl
	opengl? ( virtual/opengl )
	xscreensaver? ( x11-misc/xscreensaver )"
RDEPEND="${DEPEND}"

PATCHES="${FILESDIR}/${P}-xscreensaver.patch"

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

	kde4-meta_pkg_setup
}

src_compile() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with opengl OpenGL)
		$(cmake-utils_use_with xscreensaver Xscreensaver)"

	kde4-meta_src_compile
}

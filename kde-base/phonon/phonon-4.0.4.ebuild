# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/phonon/phonon-4.0.4.ebuild,v 1.1 2008/05/16 00:54:39 ingmar Exp $

EAPI="1"

KMNAME=kdebase-runtime
KMMODULE=phonon
inherit kde4-meta

DESCRIPTION="KDE multimedia API"
KEYWORDS="~amd64 ~x86"
IUSE="debug xcb"

# There's currently only a xine backend for phonon available,
# a gstreamer backend from TrollTech is in the works.
DEPEND="
	>=media-libs/xine-lib-1.1.9
	xcb? ( x11-libs/libxcb )"
RDEPEND="${DEPEND}"

pkg_setup() {
	if use xcb; then
		KDE4_BUILT_WITH_USE_CHECK="media-libs/xine-lib xcb"
	fi

	kde4-meta_pkg_setup
}

src_compile() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with xcb XCB)
		-DWITH_Xine=ON"

	kde4-meta_src_compile
}

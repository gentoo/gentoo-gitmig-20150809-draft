# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork-kscreensaver/kdeartwork-kscreensaver-4.2.1.ebuild,v 1.4 2009/03/13 22:25:09 scarabeus Exp $

EAPI="2"

KMMODULE="kscreensaver"
KMNAME="kdeartwork"
OPENGL_REQUIRED="optional"
inherit kde4-meta

DESCRIPTION="Extra screensavers for kde"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug +eigen +opengl +xscreensaver"

DEPEND="
	>=kde-base/kscreensaver-${PV}:${SLOT}[kdeprefix=,opengl?]
	>=kde-base/plasma-workspace-${PV}:${SLOT}[kdeprefix=]
	media-libs/libart_lgpl
	eigen? ( dev-cpp/eigen:2 )
	opengl? ( virtual/opengl )
	xscreensaver? ( x11-misc/xscreensaver )
"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${PN}-xscreensaver.patch" )

src_prepare() {
	sed -i -e 's/${KDE4WORKSPACE_KSCREENSAVER_LIBRARY}/kscreensaver/g' \
		kscreensaver/{kdesavers{,/asciiquarium},kpartsaver}/CMakeLists.txt \
		|| die "Failed to patch CMake files"

	kde4-meta_src_prepare
}

src_configure() {
	mycmakeargs="${mycmakeargs}
		-DKSCREENSAVER_SOUND_SUPPORT=ON
		$(cmake-utils_use_with eigen Eigen2)
		$(cmake-utils_use_with opengl OpenGL)
		$(cmake-utils_use_with xscreensaver Xscreensaver)"

	kde4-meta_src_configure
}

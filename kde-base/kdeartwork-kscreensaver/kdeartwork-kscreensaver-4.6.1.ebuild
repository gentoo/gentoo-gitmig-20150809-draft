# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork-kscreensaver/kdeartwork-kscreensaver-4.6.1.ebuild,v 1.1 2011/03/04 18:00:18 alexxy Exp $

EAPI=3

KMMODULE="kscreensaver"
KMNAME="kdeartwork"
OPENGL_REQUIRED="optional"
inherit kde4-meta

DESCRIPTION="Extra screensavers for kde"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug +eigen opengl xscreensaver"

# libkworkspace - only as a stub to provide KDE4Workspace config
RDEPEND="
	$(add_kdebase_dep kscreensaver 'opengl?')
	$(add_kdebase_dep libkworkspace)
	media-libs/libart_lgpl
	opengl? ( virtual/opengl )
	xscreensaver? ( x11-misc/xscreensaver )
"
DEPEND="${RDEPEND}
	eigen? ( dev-cpp/eigen:2 )
"

PATCHES=( "${FILESDIR}/${PN}-xscreensaver.patch"
	"${FILESDIR}/${PN}-4.5.95-webcollage.patch" )

src_prepare() {
	sed -i -e 's/${KDE4WORKSPACE_KSCREENSAVER_LIBRARY}/kscreensaver/g' \
		kscreensaver/{kdesavers{,/asciiquarium},kpartsaver}/CMakeLists.txt \
		|| die "Failed to patch CMake files"

	kde4-meta_src_prepare
}

src_configure() {
	mycmakeargs=(
		-DKSCREENSAVER_SOUND_SUPPORT=ON
		$(cmake-utils_use_with eigen Eigen2)
		$(cmake-utils_use_with opengl OpenGL)
		$(cmake-utils_use_with xscreensaver)
	)

	kde4-meta_src_configure
}

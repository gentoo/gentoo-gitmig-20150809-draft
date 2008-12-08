# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/amarok/amarok-1.90-r1.ebuild,v 1.4 2008/12/08 14:07:24 scarabeus Exp $

EAPI="2"

OPENGL_REQUIRED="optional"
NEED_KDE=":4.1"
inherit kde4-base

DESCRIPTION="Advanced audio player based on KDE framework."
HOMEPAGE="http://amarok.kde.org/"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="4.1"
IUSE="cdaudio daap debug ifp mp3tunes mp4 mtp mysql njb opengl visualization"
SRC_URI="mirror://kde/unstable/${PN}/${PV}/src/${P}.tar.bz2"

# daap are automagic

DEPEND="
	>=app-misc/strigi-0.5.7
	dev-db/sqlite:3[threadsafe]
	kde-base/kdelibs:${SLOT}
	kde-base/libplasma:${SLOT}
	>=media-libs/taglib-1.5
	|| ( media-sound/phonon x11-libs/qt-phonon:4 )
	x11-libs/qt-webkit:4
	cdaudio? ( kde-base/libkcddb:${SLOT}
		kde-base/libkcompactdisc:${SLOT} )
	ifp? ( media-libs/libifp )
	mp3tunes? ( net-misc/curl
		    dev-libs/libxml2 )
	mp4? ( media-libs/libmp4v2 )
	mtp? ( >=media-libs/libmtp-0.3.3 )
	mysql? ( >=virtual/mysql-4.0 )
	njb? ( >=media-libs/libnjb-2.2.4 )
	opengl? ( virtual/opengl )
	visualization? ( media-libs/libsdl
		=media-plugins/libvisual-plugins-0.4* )
	"
RDEPEND="${DEPEND}
	app-arch/unzip
	daap? ( www-servers/mongrel )
	"

src_configure() {
	if use debug; then
		mycmakeargs="${mycmakeargs} -DCMAKE_BUILD_TYPE=debugfull"
	fi
	# fix redefinition warnings
	sed -i \
		-e 's/ -DQT_WEBKIT//g' \
		"${S}"/src/scriptengine/generator/generator/CMakeLists.txt \
		|| die "Removing unnecessary -DQT_WEBKIT failed."
	# disable ipod bug #245112
	mycmakeargs="${mycmakeargs}
		-DCMAKE_INSTALL_PREFIX=${PREFIX}
		-DUSE_SYSTEM_SQLITE=ON
		-DWITH_Ipod=OFF
		$(cmake-utils_use_with cdaudio KdeMultimedia)
		$(cmake-utils_use_with ifp Ifp)
		$(cmake-utils_use_with mp4 Mp4v2)
		$(cmake-utils_use_with mtp Mtp)
		$(cmake-utils_use_with mysql MySQL)
		$(cmake-utils_use_with njb Njb)
		$(cmake-utils_use_with opengl OpenGL)
		$(cmake-utils_use_with visualization Libvisual)
	"
	kde4-base_src_configure
}

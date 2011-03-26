# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/allegro/allegro-5.0.1.ebuild,v 1.1 2011/03/26 16:57:58 ssuominen Exp $

EAPI=2
inherit cmake-utils

DESCRIPTION="A game programming library"
HOMEPAGE="http://alleg.sourceforge.net/"
SRC_URI="mirror://sourceforge/alleg/${P}.tar.gz"

LICENSE="BSD ZLIB"
SLOT="0"
#KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
KEYWORDS=""
IUSE="alsa dumb flac gtk jpeg openal opengl oss physfs png pulseaudio test truetype vorbis X xinerama"

RDEPEND="alsa? ( media-libs/alsa-lib )
	dumb? ( media-libs/dumb )
	flac? ( media-libs/flac )
	jpeg? ( virtual/jpeg )
	openal? ( media-libs/openal )
	physfs? ( dev-games/physfs )
	png? ( >=media-libs/libpng-1.4 )
	pulseaudio? ( >=media-sound/pulseaudio-0.9.15 )
	truetype? ( >=media-libs/freetype-2
		sys-libs/zlib )
	vorbis? ( media-libs/libvorbis )
	X? (
		x11-libs/libXext
		x11-libs/libXcursor
		x11-libs/libXxf86vm
		x11-libs/libXrandr
		x11-libs/libX11
		x11-libs/libXpm
		gtk? ( x11-libs/gtk+:2 )
		opengl? ( virtual/opengl )
		xinerama? ( x11-libs/libXinerama )
	)
	!media-libs/aldumb
	!media-libs/allegrogl
	!media-libs/jpgalleg"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	X? (
		x11-proto/xextproto
		x11-proto/xf86vidmodeproto
		x11-proto/xproto
	)"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_want alsa)
		-DWANT_DEMO=OFF
		-DWANT_EXAMPLES=OFF
		$(cmake-utils_use_want flac)
		$(cmake-utils_use_want jpeg IMAGE_JPG)
		$(cmake-utils_use_want png IMAGE_PNG)
		$(cmake-utils_use_want dumb MODAUDIO)
		$(cmake-utils_use_want openal)
		$(cmake-utils_use_want opengl)
		$(cmake-utils_use_want oss)
		$(cmake-utils_use_want physfs)
		$(cmake-utils_use_want pulseaudio)
		$(cmake-utils_use_want test TESTS)
		$(cmake-utils_use_want truetype TTF)
		$(cmake-utils_use_want vorbis)
		$(cmake-utils_use_want X X11)
		)

	if use X; then
		mycmakeargs+=(
			$(cmake-utils_use_want gtk NATIVE_DIALOG)
			$(cmake-utils_use_want opengl)
			$(cmake-utils_use_want xinerama X11_XINERAMA)
			)
	else
		mycmakeargs+=(
			-DWANT_NATIVE_DIALOG=OFF
			-DWANT_OPENGL=OFF
			-DWANT_X11_XINERAMA=OFF
			)
	fi

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	dohtml -r docs/html/refman/* || die
	doman docs/man/*.3 || die
}

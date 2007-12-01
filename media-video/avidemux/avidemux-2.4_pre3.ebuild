# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/avidemux/avidemux-2.4_pre3.ebuild,v 1.5 2007/12/01 18:08:15 drac Exp $

inherit cmake-utils eutils

MY_P=${PN}_${PV/pre/preview}

DESCRIPTION="Video editor designed for simple cutting, filtering and encoding tasks."
HOMEPAGE="http://fixounet.free.fr/avidemux"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="aac aften alsa amrnb arts dts encode esd fontconfig jack libsamplerate
x264 xv xvid vorbis truetype gtk qt4"

RDEPEND="dev-libs/libxml2
	media-libs/libpng
	media-libs/libsdl
	>=dev-libs/glib-2
	alsa? ( media-libs/alsa-lib )
	fontconfig? ( media-libs/fontconfig )
	xv? ( x11-libs/libXv )
	esd? ( media-sound/esound )
	jack? ( media-sound/jack-audio-connection-kit )
	aften? ( media-libs/aften )
	libsamplerate? ( media-libs/libsamplerate )
	xvid? ( media-libs/xvid )
	amrnb? ( media-libs/amrnb )
	dts? ( media-libs/libdca )
	x264? ( media-libs/x264-svn )
	aac? ( media-libs/faad2 )
	vorbis? ( media-libs/libvorbis )
	arts? ( kde-base/arts )
	truetype? ( media-libs/freetype )
	gtk? ( >=x11-libs/gtk+-2
		x11-libs/libX11 )
	qt4? ( >=x11-libs/qt-4
		x11-libs/libX11 )
	encode? (
		aac? ( media-libs/faac )
		media-sound/lame )"
DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/pkgconfig
	>=dev-util/cmake-2.4.4"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-libdca.patch
	epatch "${FILESDIR}"/${P}-i18n.patch
}

src_compile() {
	# Commented options are breaking the build. -drac

	local mycmakeargs

	# ConfigureChecks.cmake
	use alsa || mycmakeargs="${mycmakeargs} -DNO_ALSA=1"
	#use oss || mycmakeargs="${mycmakeargs} -DNO_OSS=1"
	#use nls || mycmakeargs="${mycmakeargs} -DNO_NLS=1"
	#use sdl || mycmakeargs="${mycmakeargs} -DNO_SDL=1"

	# ConfigureChecks.cmake -> ADM_CHECK_HL -> cmake/adm_checkHeaderLib.cmake
	use fontconfig || mycmakeargs="${mycmakeargs} -DNO_FontConfig=1"
	use xv || mycmakeargs="${mycmakeargs} -DNO_Xvideo=1"
	use esd || mycmakeargs="${mycmakeargs} -DNO_Esd=1"
	use jack || mycmakeargs="${mycmakeargs} -DNO_Jack=1"
	use aften || mycmakeargs="${mycmakeargs} -DNO_Aften=1"
	use libsamplerate || mycmakeargs="${mycmakeargs} -DNO_libsamplerate=1"
	use encode || mycmakeargs="${mycmakeargs} -DNO_Lame=1 -DNO_FAAC=1"
	use xvid || mycmakeargs="${mycmakeargs} -DNO_Xvid=1"
	use amrnb || mycmakeargs="${mycmakeargs} -DNO_AMRNB=1"
	use dts || mycmakeargs="${mycmakeargs} -DNO_libdca=1"
	use x264 || mycmakeargs="${mycmakeargs} -DNO_x264=1"
	use aac || mycmakeargs="${mycmakeargs} -DNO_FAAD=1 -DNO_NeAAC=1"
	use vorbis || mycmakeargs="${mycmakeargs} -DNO_Vorbis=1"
	#use png || mycmakeargs="${mycmakeargs} -DNO_libPNG=1"

	# ConfigureChecks.cmake -> cmake/FindArts.cmake
	use arts || mycmakeargs="${mycmakeargs} -DNO_ARTS=1"

	# CMakeLists.txt
	use truetype || mycmakeargs="${mycmakeargs} -DNO_FREETYPE=1"
	use gtk || mycmakeargs="${mycmakeargs} -DNO_GTK=1"
	use qt4 || mycmakeargs="${mycmakeargs} -DNO_QT4=1"

	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install
	dodoc AUTHORS

	doicon avidemux_icon.png

	use gtk && make_desktop_entry avidemux2_gtk "Avidemux GTK" \
		avidemux_icon "AudioVideo;GTK;"
	use qt4 && make_desktop_entry avidemux2_qt4 "Avidemux QT" \
		avidemux_icon "AudioVideo;Qt;"
}

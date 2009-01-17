# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/avidemux/avidemux-2.4.3.ebuild,v 1.7 2009/01/17 20:52:14 yngwin Exp $

EAPI="1"

inherit cmake-utils eutils flag-o-matic

MY_P=${PN}_${PV}

DESCRIPTION="Video editor designed for simple cutting, filtering and encoding tasks."
HOMEPAGE="http://fixounet.free.fr/avidemux"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="amd64 ppc x86"
IUSE="aac aften alsa amrnb arts dts encode esd jack lame libsamplerate
	truetype vorbis x264 xv xvid gtk qt4"

RDEPEND="dev-libs/libxml2
	media-libs/libpng
	media-libs/libsdl
	>=dev-libs/glib-2
	aac? ( media-libs/faad2 )
	aften? ( media-libs/aften )
	alsa? ( media-libs/alsa-lib )
	amrnb? ( media-libs/amrnb )
	arts? ( kde-base/arts )
	dts? ( media-libs/libdca )
	encode? (
		aac? ( media-libs/faac )
		lame? ( media-sound/lame )
		)
	esd? ( media-sound/esound )
	jack? ( media-sound/jack-audio-connection-kit )
	libsamplerate? ( media-libs/libsamplerate )
	truetype? ( media-libs/freetype
		media-libs/fontconfig )
	vorbis? ( media-libs/libvorbis )
	x264? ( media-libs/x264 )
	xv? ( x11-libs/libXv )
	xvid? ( media-libs/xvid )
	gtk? ( >=x11-libs/gtk+-2
		x11-libs/libX11 )
	qt4? ( || ( x11-libs/qt-gui:4
			>=x11-libs/qt-4.3:4 )
		x11-libs/libX11 )"
DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/pkgconfig
	>=dev-util/cmake-2.4.4"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	if hasq distcc ${FEATURES}; then
		eerror "Avidemux does not compile with distcc. Please retry with"
		eerror "FEATURES='-distcc' emerge avidemux"
		die "distcc not supported for this package"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	# TODO. Needs to be reported upstream.
	epatch "${FILESDIR}"/${PN}-2.4-libdca.patch
	epatch "${FILESDIR}"/${PN}-2.4-i18n.patch
	# Upstream patch for newer x264
	epatch "${FILESDIR}"/${P}-x264.patch
	# Fix compile error triggered by -ftracer (bug 255268)
	epatch "${FILESDIR}"/lavcodec-mpegvideo_mmx-asm-fix.patch
}

src_compile() {
	# Commented out options cause compilation errors, some
	# might need -Wl,--as-needed in LDFLAGS and all USE
	# flags disabled for reproducing. -drac
	# TODO. Needs to be fixed, or reported upstream.

	local mycmakeargs

	# ConfigureChecks.cmake
	use alsa || mycmakeargs="${mycmakeargs} -DNO_ALSA=1"
	#use oss || mycmakeargs="${mycmakeargs} -DNO_OSS=1"
	#use nls || mycmakeargs="${mycmakeargs} -DNO_NLS=1"
	#use sdl || mycmakeargs="${mycmakeargs} -DNO_SDL=1"

	# ConfigureChecks.cmake -> ADM_CHECK_HL -> cmake/adm_checkHeaderLib.cmake
	use truetype || mycmakeargs="${mycmakeargs} -DNO_FontConfig=1"
	use xv || mycmakeargs="${mycmakeargs} -DNO_Xvideo=1"
	use esd || mycmakeargs="${mycmakeargs} -DNO_Esd=1"
	use jack || mycmakeargs="${mycmakeargs} -DNO_Jack=1"
	use aften || mycmakeargs="${mycmakeargs} -DNO_Aften=1"
	use libsamplerate || mycmakeargs="${mycmakeargs} -DNO_libsamplerate=1"
	use encode && use aac || mycmakeargs="${mycmakeargs} -DNO_FAAC=1"
	use encode && use lame || mycmakeargs="${mycmakeargs} -DNO_Lame=1"
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
	dodoc AUTHORS History
	doicon avidemux_icon.png

	use gtk && make_desktop_entry avidemux2_gtk "Avidemux GTK" \
		avidemux_icon "AudioVideo;GTK"
	use qt4 && make_desktop_entry avidemux2_qt4 "Avidemux Qt" \
		avidemux_icon "AudioVideo;Qt"
}

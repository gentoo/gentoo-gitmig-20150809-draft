# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/lmms/lmms-0.4.0_rc2.ebuild,v 1.1 2008/09/23 21:00:59 aballier Exp $

EAPI="1"

inherit eutils cmake-utils

MY_P="${P/_/-}"

DESCRIPTION="free alternative to popular programs such as Fruityloops, Cubase and Logic"
HOMEPAGE="http://lmms.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~amd64"

IUSE="alsa debug fftw fluidsynth jack ogg pch portaudio pulseaudio sdl stk vst"

RDEPEND="|| ( (
				x11-libs/qt-core
				x11-libs/qt-gui
			) >=x11-libs/qt-4.3.0:4 )
	>=media-libs/libsndfile-1.0.11
	media-libs/libsamplerate
	alsa? ( media-libs/alsa-lib )
	fftw? ( =sci-libs/fftw-3* )
	jack? ( >=media-sound/jack-audio-connection-kit-0.99.0 )
	ogg? ( media-libs/libvorbis
			media-libs/libogg )
	fluidsynth? ( media-sound/fluidsynth )
	portaudio? ( media-libs/portaudio )
	pulseaudio? ( media-sound/pulseaudio )
	sdl? ( media-libs/libsdl
			>=media-libs/sdl-sound-1.0.1 )
	stk? ( media-libs/stk )
	vst? ( app-emulation/wine )"
DEPEND="${RDEPEND}
	>=dev-util/cmake-2.4.5"

S="${WORKDIR}/${MY_P}"

DOCS="README AUTHORS ChangeLog TODO"

src_compile() {
	mycmakeargs="${mycmakeargs}
		-DWANT_SYSTEM_SR=TRUE
		-DWANT_CAPS=TRUE
		-DWANT_TAP=TRUE
		$(cmake-utils_use_want alsa ALSA)
		$(cmake-utils_use_want fftw FFTW3F)
		$(cmake-utils_use_want jack JACK)
		$(cmake-utils_use_want ogg OGGVORBIS)
		$(cmake-utils_use_want portaudio PORTAUDIO)
		$(cmake-utils_use_want pulseaudio PULSEAUDIO)
		$(cmake-utils_use_want sdl SDL)
		$(cmake-utils_use_want stk STK)
		$(cmake-utils_use_want vst VST)
		$(cmake-utils_use_want fluidsynth SF2)
		$(cmake-utils_use_want pch PCH)"

	cmake-utils_src_compile
}

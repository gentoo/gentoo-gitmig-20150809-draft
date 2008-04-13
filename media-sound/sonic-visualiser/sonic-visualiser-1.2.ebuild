# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/sonic-visualiser/sonic-visualiser-1.2.ebuild,v 1.2 2008/04/13 23:04:58 aballier Exp $

EAPI=1

inherit eutils qt4

DESCRIPTION="Music audio files viewer and analiser"
HOMEPAGE="http://www.sonicvisualiser.org/"
SRC_URI="mirror://sourceforge/sv1/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="fftw id3tag jack mad ogg"

RDEPEND="|| ( ( x11-libs/qt-core:4  x11-libs/qt-gui:4 )
				>=x11-libs/qt-4.3:4 )
	media-libs/libsndfile
	media-libs/libsamplerate
	fftw? ( =sci-libs/fftw-3* )
	app-arch/bzip2
	>=media-libs/dssi-0.9.1
	media-libs/raptor
	media-libs/liblrdf
	media-libs/ladspa-sdk
	media-libs/liblo
	media-libs/speex
	media-libs/vamp-plugin-sdk
	media-libs/rubberband
	jack? ( media-sound/jack-audio-connection-kit )
	mad? ( media-libs/libmad )
	id3tag? ( media-libs/libid3tag )
	ogg? ( media-libs/libfishsound media-libs/liboggz )"

DEPEND="${RDEPEND}
		>=dev-util/pkgconfig-0.9"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# needs portaudio v19
	sed -i -e "s:DEFINES += HAVE_PORTAUDIO:#DEFINES += HAVE_PORTAUDIO:" \
		-e "s:LIBS    += -lportaudio:#LIBS    += -lportaudio:" \
		sv.prf
	# remove crap
	sed -i -e "s:-O3 -march=pentium3 -msse -mmmx::" sv.prf
}

sv_disable_opt() {
	find . -name "*.pro" -exec sed -i -e "s/ $1//" {} \; || die "failed to remove $1 support"
}

src_compile() {
	use jack || sv_disable_opt jack
	use ogg || sv_disable_opt fishsound
	use ogg || sv_disable_opt oggz
	use mad || sv_disable_opt mad
	use fftw || sv_disable_opt fftw3f
	use id3tag || sv_disable_opt id3tag
	sv_disable_opt portaudio

	eqmake4
	emake -j1 || die "Compilation failed"
}

src_install() {
	dobin sv/sonic-visualiser
	dodoc README README.OSC
	dodir /usr/share/${PN}
	#install samples
	insinto /usr/share/${PN}/samples
	doins sv/samples/*
	# desktop entry
	newicon "sv/icons/sv-48x48.png" "${PN}.png"
	make_desktop_entry "${PN}" "Sonic Visualiser" "${PN}"
}

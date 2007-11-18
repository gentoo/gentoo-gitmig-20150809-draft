# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/sonic-visualiser/sonic-visualiser-1.0.ebuild,v 1.1 2007/11/18 19:12:43 aballier Exp $

inherit eutils qt4

DESCRIPTION="Music audio files viewer and analiser"
HOMEPAGE="http://www.sonicvisualiser.org/"
SRC_URI="mirror://sourceforge/sv1/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="fftw jack mad ogg"

RDEPEND="$(qt4_min_version 4.2)
	media-libs/libsndfile
	media-libs/libsamplerate
	fftw? ( =sci-libs/fftw-3* )
	app-arch/bzip2
	>=media-libs/dssi-0.9.1
	media-libs/raptor
	media-libs/liblrdf
	media-libs/ladspa-sdk
	media-libs/liblo
	media-libs/libfishsound
	media-libs/speex
	media-libs/vamp-plugin-sdk
	jack? ( media-sound/jack-audio-connection-kit )
	mad? ( media-libs/libmad )
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
	sed -i -e "s:-O2 -march=pentium3 -mfpmath=sse::" sv.prf

	epatch "${FILESDIR}/${P}-loarg.patch"
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
	make_desktop_entry "${PN}" "Sonic Visualiser" "${PN}" "AudioVideo;Audio;"
}

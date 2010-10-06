# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/sonic-visualiser/sonic-visualiser-1.7.2.ebuild,v 1.1 2010/10/06 00:02:39 xmw Exp $

EAPI=2

inherit eutils qt4

DESCRIPTION="Music audio files viewer and analiser"
HOMEPAGE="http://www.sonicvisualiser.org/"
SRC_URI="mirror://sourceforge/sv1/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="fftw id3tag jack mad ogg osc portaudio pulseaudio"

RDEPEND="x11-libs/qt-core:4
	x11-libs/qt-gui:4
	media-libs/libsndfile
	media-libs/libsamplerate
	fftw? ( =sci-libs/fftw-3* )
	app-arch/bzip2
	>=media-libs/dssi-0.9.1
	media-libs/raptor
	media-libs/liblrdf
	dev-libs/redland
	media-libs/ladspa-sdk
	osc? ( media-libs/liblo )
	media-libs/speex
	>=media-libs/vamp-plugin-sdk-2.0
	media-libs/rubberband
	jack? ( media-sound/jack-audio-connection-kit )
	!pulseaudio? ( !portaudio? ( media-sound/jack-audio-connection-kit ) )
	mad? ( media-libs/libmad )
	id3tag? ( media-libs/libid3tag )
	ogg? ( media-libs/libfishsound media-libs/liboggz )
	portaudio? ( >=media-libs/portaudio-19_pre20071207 )
	pulseaudio? ( media-sound/pulseaudio )"

DEPEND="${RDEPEND}
		>=dev-util/pkgconfig-0.9"

pkg_setup() {
	use !jack && use !pulseaudio && use !portaudio && ewarn "You must have at least one of: jack, pulseaudio, portaudio enabled. We will enable jack for you."
}

src_prepare() {
	# remove crap
	sed -i -e "s:-O3::" prf/sv.prf
	has_version '>=media-libs/liboggz-1.1.0' && epatch "${FILESDIR}/${PN}-1.7.1-liboggz11.patch"
}

sv_disable_opt() {
	einfo "Disabling $1"
	sed -i -e "s/ $1//" "${S}/prf/sv.prf" || die "failed to remove $1 support"
}

src_compile() {
	(use jack || ( use !pulseaudio && use !portaudio)) || sv_disable_opt jack
	use ogg || sv_disable_opt fishsound
	use ogg || sv_disable_opt oggz
	use mad || sv_disable_opt mad
	use fftw || sv_disable_opt fftw3f
	use fftw || sv_disable_opt fftw3
	use id3tag || sv_disable_opt id3tag
	use pulseaudio || sv_disable_opt libpulse
	use portaudio || sv_disable_opt portaudio
	use osc || sv_disable_opt liblo

	eqmake4
	emake || die "Compilation failed"
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

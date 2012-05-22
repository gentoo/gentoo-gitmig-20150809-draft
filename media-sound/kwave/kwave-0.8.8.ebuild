# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/kwave/kwave-0.8.8.ebuild,v 1.2 2012/05/22 15:26:32 kensington Exp $

EAPI=4

KDE_LINGUAS="cs de fr"
KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="A sound editor for KDE that can edit many types of audio files"
HOMEPAGE="http://kwave.sourceforge.net/"
SRC_URI="mirror://sourceforge/kwave/${P}-1.tar.bz2"

LICENSE="BSD FDL-1.2 GPL-2 LGPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="alsa debug flac libsamplerate mad oss pulseaudio vorbis"

RDEPEND="
	media-libs/audiofile
	>=sci-libs/fftw-3
	alsa? ( media-libs/alsa-lib )
	flac? ( media-libs/flac )
	libsamplerate? ( media-libs/libsamplerate )
	mad? (
		media-libs/id3lib
		media-libs/libmad
	)
	pulseaudio? ( media-sound/pulseaudio )
	vorbis? (
		media-libs/libogg
		media-libs/libvorbis
	)
"
DEPEND="${RDEPEND}
	$(add_kdebase_dep kdesdk-misc extras)
	|| ( media-gfx/imagemagick[png] media-gfx/graphicsmagick[imagemagick,png] )
"

DOCS=( AUTHORS CHANGES README TODO )

src_prepare() {
	sed -e 's/ -Wl,--add-needed//' -i plugins/CMakeLists.txt \
		|| die "sed failed"
	kde4-base_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DWITH_SAMPLERATE=ON
		-DWITH_PHONON=ON
		$(cmake-utils_use_with alsa)
		$(cmake-utils_use_with flac)
		$(cmake-utils_use_with libsamplerate SAMPLERATE)
		$(cmake-utils_use_with mad MP3)
		$(cmake-utils_use_with vorbis OGG)
		$(cmake-utils_use_with oss)
		$(cmake-utils_use_with pulseaudio)
		$(cmake-utils_use debug)
	)

	kde4-base_src_configure
}

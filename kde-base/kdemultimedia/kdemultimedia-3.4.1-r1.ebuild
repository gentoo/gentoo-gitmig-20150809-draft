# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdemultimedia/kdemultimedia-3.4.1-r1.ebuild,v 1.8 2005/08/25 14:45:35 agriffis Exp $

inherit kde-dist eutils

DESCRIPTION="KDE multimedia apps: noatun, kscd, juk..."

KEYWORDS="~alpha amd64 hppa ia64 ppc sparc x86"
IUSE="alsa audiofile encode flac gstreamer jack mp3 speex theora vorbis xine"

DEPEND="~kde-base/kdebase-${PV}
	media-sound/cdparanoia
	media-libs/libsamplerate
	audiofile? ( media-libs/audiofile )
	mp3? ( media-libs/libmad )
	jack? ( media-sound/jack-audio-connection-kit )
	flac? ( media-libs/flac )
	encode? ( media-sound/lame )
	vorbis? ( media-sound/vorbis-tools )
	xine? ( >=media-libs/xine-lib-1.0 )
	alsa? ( media-libs/alsa-lib )
	speex? ( media-libs/speex )
	theora? ( media-libs/libtheora )
	gstreamer? ( >=media-libs/gstreamer-0.8
	             >=media-libs/gst-plugins-0.8 )
	>=media-libs/taglib-1.2
	media-libs/tunepimp"

RDEPEND="${DEPEND}
	gstreamer? ( mp3? ( >=media-plugins/gst-plugins-mad-0.8 )
		     vorbis? ( >=media-plugins/gst-plugins-ogg-0.8
		                  >=media-plugins/gst-plugins-vorbis-0.8 )
		     flac? ( >=media-plugins/gst-plugins-flac-0.8 ) )"

src_unpack() {
	kde_src_unpack

	epatch "${FILESDIR}/kdemultimedia-3.4.0-amd64.patch"

	# Fix regression: juk hangs with akode engine (kde bug 105342). Applied for 3.4.2.
	epatch "${FILESDIR}/${P}-akode-hang.patch"
}

src_compile() {
	use speex && myconf="--with-extra-includes=/usr/include/speex"

	use xine && myconf="${myconf} --with-xine-prefix=/usr"
	use xine || DO_NOT_COMPILE="${DO_NOT_COMPILE} xine_artsplugin"

	myconf="${myconf} --with-cdparanoia --enable-cdparanoia
		$(use_with alsa arts-alsa) $(use_with alsa)
		$(use_with vorbis) $(use_with encode lame)
		$(use_with flac) $(use_with speex)
		$(use_with mp3 libmad) $(use_with jack)"

	kde_src_compile
}

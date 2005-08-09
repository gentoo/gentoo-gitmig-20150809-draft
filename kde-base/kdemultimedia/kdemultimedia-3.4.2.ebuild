# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdemultimedia/kdemultimedia-3.4.2.ebuild,v 1.3 2005/08/09 10:28:31 greg_g Exp $

inherit kde-dist eutils

DESCRIPTION="KDE multimedia apps: noatun, kscd, juk..."

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86"
IUSE="alsa audiofile encode flac gstreamer jack mp3 musicbrainz speex theora vorbis xine"

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
	musicbrainz? ( media-libs/tunepimp media-libs/musicbrainz )"

RDEPEND="${DEPEND}
	gstreamer? ( mp3? ( >=media-plugins/gst-plugins-mad-0.8 )
		     vorbis? ( >=media-plugins/gst-plugins-ogg-0.8
		               >=media-plugins/gst-plugins-vorbis-0.8 )
		     flac? ( >=media-plugins/gst-plugins-flac-0.8 ) )"

DEPEND="${DEPEND}
	dev-util/pkgconfig"

src_unpack() {
	kde_src_unpack

	# Fix for 64 bit systems. Applied for 3.5.
	epatch "${FILESDIR}/kdemultimedia-3.4.0-amd64.patch"

	# Configure patch. Applied for 3.5.
	epatch "${FILESDIR}/kdemultimedia-3.4-configure.patch"

	# For the configure patch.
	make -f admin/Makefile.common
}

src_compile() {
	use speex && myconf="--with-extra-includes=/usr/include/speex"

	myconf="${myconf} --with-cdparanoia --enable-cdparanoia
		$(use_with alsa arts-alsa) $(use_with alsa)
		$(use_with vorbis) $(use_with encode lame)
		$(use_with flac) $(use_with speex)
		$(use_with mp3 libmad) $(use_with jack)
		$(use_with xine) $(use_with musicbrainz)"

	kde_src_compile
}

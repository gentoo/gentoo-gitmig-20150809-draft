# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdemultimedia/kdemultimedia-3.5.2.ebuild,v 1.2 2006/04/18 19:50:23 flameeyes Exp $

inherit kde-dist

DESCRIPTION="KDE multimedia apps: noatun, kscd, juk..."

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="alsa audiofile encode flac gstreamer mp3 musicbrainz theora vorbis xine"

DEPEND="~kde-base/kdebase-${PV}
	media-sound/cdparanoia
	media-libs/akode
	>=media-libs/taglib-1.2
	audiofile? ( media-libs/audiofile )
	xine? ( >=media-libs/xine-lib-1.0 )
	alsa? ( media-libs/alsa-lib )
	theora? ( media-libs/libtheora )
	gstreamer? ( =media-libs/gstreamer-0.8*
	             =media-libs/gst-plugins-0.8* )
	musicbrainz? ( media-libs/tunepimp
	               media-libs/musicbrainz )
	encode? ( mp3? ( media-sound/lame )
	          vorbis? ( media-sound/vorbis-tools )
	          flac? ( media-libs/flac ) )
	|| ( (
			x11-libs/libXext
			x11-libs/libXxf86dga
			x11-libs/libXxf86vm
		) virtual/x11 )"

RDEPEND="${DEPEND}
	gstreamer? ( mp3? ( =media-plugins/gst-plugins-mad-0.8* )
		     vorbis? ( =media-plugins/gst-plugins-ogg-0.8*
		               =media-plugins/gst-plugins-vorbis-0.8* )
		     flac? ( =media-plugins/gst-plugins-flac-0.8* ) )"

DEPEND="${DEPEND}
	dev-util/pkgconfig
	|| ( (
			x11-proto/xf86dgaproto
			x11-proto/xf86vidmodeproto
			x11-proto/videoproto
			x11-proto/xextproto
		) virtual/x11 )"

src_compile() {
	local myconf="--with-cdparanoia --with-taglib
	              --with-akode $(use_with alsa)
	              $(use_with audiofile) $(use_with gstreamer)
	              $(use_with xine) $(use_with theora)
	              $(use_with musicbrainz)"

	# encoding can happen through:
	# - kio_audiocd (based on libflac for flac,
	#   on libvorbis for vorbis, on the lame binary for mp3)
	# - kaudiocreator (based on the flac binary for flac,
	#   on the lame binary for mp3, on the oggenc binary for vorbis)
	# - krec (based on libvorbis for vorbis,
	#   on libmp3lame for mp3)
	if use encode; then
		myconf="${myconf} $(use_with mp3 lame)
	                $(use_with vorbis) $(use_with flac)"
	else
		myconf="${myconf} --without-lame
	                --without-vorbis --without-flac"
	fi

	# Not used anymore and scheduled for removal.
	export DO_NOT_COMPILE="${DO_NOT_COMPILE} mpeglib mpeglib_artsplug"

	kde_src_compile
}

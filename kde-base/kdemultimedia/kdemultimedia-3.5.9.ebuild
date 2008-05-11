# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdemultimedia/kdemultimedia-3.5.9.ebuild,v 1.3 2008/05/11 18:04:05 corsair Exp $

EAPI="1"
inherit kde-dist flag-o-matic

DESCRIPTION="KDE multimedia apps: Noatun, KsCD, Juk..."

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ppc64 ~sparc ~x86"
IUSE="akode alsa audiofile encode flac gstreamer mp3 theora vorbis xine"

DEPEND="media-sound/cdparanoia
	akode? ( media-libs/akode )
	>=media-libs/taglib-1.2
	audiofile? ( media-libs/audiofile )
	xine? ( >=media-libs/xine-lib-1.0 )
	alsa? ( media-libs/alsa-lib )
	theora? (
		media-libs/libvorbis
		media-libs/libtheora )
	gstreamer? ( =media-libs/gstreamer-0.10*
				=media-libs/gst-plugins-base-0.10* )
	encode? ( mp3? ( media-sound/lame )
			vorbis? ( media-sound/vorbis-tools )
			flac? ( >=media-libs/flac-1.1.2 ) )
	!arts? ( !gstreamer? ( media-libs/akode ) )"

RDEPEND="${DEPEND}
	gstreamer? ( mp3? ( =media-plugins/gst-plugins-mad-0.10* )
			 vorbis? ( =media-plugins/gst-plugins-ogg-0.10*
					   =media-plugins/gst-plugins-vorbis-0.10* )
			 flac? ( =media-plugins/gst-plugins-flac-0.10* ) )"

DEPEND="${DEPEND}
	dev-util/pkgconfig"

PATCHES="${FILESDIR}/kdemultimedia-3.5.5+flac-1.1.3.patch
		${FILESDIR}/kdemultimedia-kioslaves-3.5.8-freebsd.patch"

pkg_setup() {
	kde_pkg_setup
	if ! use arts && ! use gstreamer && ! use akode ; then
		ewarn "No audio backend chosen. Defaulting to media-libs/akode."
	fi
}

src_compile() {
	local myconf="--with-cdparanoia
				--with-taglib
				--with-akode
				$(use_with alsa)
				$(use_with audiofile)
				$(use_with gstreamer)
				$(use_with xine)
				$(use_with theora)
				--without-musicbrainz"

	# encoding can happen through:
	# - kio_audiocd (based on libflac for flac,
	#	on libvorbis for vorbis, on the lame binary for mp3)
	# - kaudiocreator (based on the flac binary for flac,
	#	on the lame binary for mp3, on the oggenc binary for vorbis)
	# - krec (based on libvorbis for vorbis,
	#	on libmp3lame for mp3)
	if use encode; then
		myconf="${myconf}
				$(use_with mp3 lame)
				$(use_with vorbis)
				$(use_with flac)"
	else
		myconf="${myconf}
				--without-lame
				--without-vorbis
				--without-flac"
	fi

	if ! use arts && ! use gstreamer ; then
		myconf="${myconf} --with-akokde"
	else
		if ! use akode ; then
			# work around broken configure
			export include_akode_ffmpeg_FALSE='#'
			export include_akode_mpc_FALSE='#'
			export include_akode_mpeg_FALSE='#'
			export include_akode_xiph_FALSE='#'
		fi
		myconf="${myconf} $(use_with akode)"
	fi

	# fix bug 128884
	filter-flags -fomit-frame-pointer

	# Not used anymore and scheduled for removal.
	export DO_NOT_COMPILE="${DO_NOT_COMPILE} mpeglib mpeglib_artsplug"

	rm configure
	kde_src_compile
}

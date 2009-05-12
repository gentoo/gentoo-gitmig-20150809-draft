# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/aqualung/aqualung-0.9_beta10-r1.ebuild,v 1.2 2009/05/12 16:30:41 ssuominen Exp $

EAPI=2
inherit autotools eutils versionator

MY_PV="$(delete_version_separator 2)"
MY_PV="${MY_PV/_p/.}"

DESCRIPTION="A music player for a wide range of formats designed for gapless playback"
HOMEPAGE="http://aqualung.factorial.hu/"
SRC_URI="mirror://sourceforge/aqualung/${PN}-${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE="sndfile modplug mp3 vorbis speex flac musepack wavpack ffmpeg ladspa
	cddb cdda ifp jack lua alsa oss lame systray libsamplerate podcast debug"
KEYWORDS="~amd64 ~x86"

RDEPEND="vorbis? ( media-libs/libvorbis )
	sndfile? ( media-libs/libsndfile )
	flac? ( media-libs/flac )
	modplug? ( media-libs/libmodplug )
	alsa? ( virtual/alsa )
	mp3? ( media-libs/libmad )
	lame? ( media-sound/lame )
	musepack? ( media-libs/libmpcdec )
	ffmpeg? ( media-video/ffmpeg )
	speex? ( media-libs/speex media-libs/liboggz )
	wavpack? ( media-sound/wavpack )
	cddb? ( media-libs/libcddb )
	jack? ( media-sound/jack-audio-connection-kit )
	cdda? ( dev-libs/libcdio )
	ifp? ( media-libs/libifp )
	lua? ( dev-lang/lua )
	libsamplerate? ( media-libs/libsamplerate )
	x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	ladspa? ( media-libs/liblrdf )
	dev-util/pkgconfig
	dev-libs/libxml2"

S=${WORKDIR}/${PN}-${MY_PV}

src_prepare() {
	# See bug 255874
	eautoreconf
}

src_configure() {
	econf \
		$(use_with alsa) \
		$(use_with oss) \
		$(use_with jack) \
		$(use_with flac) \
		$(use_with vorbis ogg) \
		$(use_with vorbis vorbisenc) \
		$(use_with sndfile) \
		$(use_with mp3 mpeg) \
		$(use_with lame) \
		$(use_with modplug mod) \
		$(use_with musepack mpc) \
		$(use_with ffmpeg lavc) \
		$(use_with speex) \
		$(use_with wavpack) \
		$(use_with cddb) \
		$(use_with systray) \
		$(use_with ladspa) \
		$(use_with cdda) \
		$(use_with lua) \
		$(use_with ifp) \
		$(use_with libsamplerate src) \
		$(use_with podcast) \
		$(use_enable debug) \
		--with-loop \
		|| die "econf failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "make install failed"
	dodoc AUTHORS README || die "dodoc failed"
	newicon src/img/icon_64.png aqualung.png
	make_desktop_entry aqualung Aqualung
}

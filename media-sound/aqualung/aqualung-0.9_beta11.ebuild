# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/aqualung/aqualung-0.9_beta11.ebuild,v 1.6 2011/03/31 20:55:24 billie Exp $

EAPI=2

inherit eutils versionator

MY_PV=$(delete_version_separator 2)
MY_PV=${MY_PV/_p/.}

DESCRIPTION="A music player for a wide range of formats designed for gapless playback"
HOMEPAGE="http://aqualung.factorial.hu/"
SRC_URI="mirror://sourceforge/aqualung/${PN}-${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE="alsa cdda cddb debug flac ffmpeg ifp jack ladspa lame libsamplerate lua
	mac modplug mp3 musepack oss podcast pulseaudio sndfile speex systray vorbis wavpack"
KEYWORDS="amd64 x86"

RDEPEND="alsa? ( media-libs/alsa-lib )
	cdda? ( dev-libs/libcdio )
	cddb? ( media-libs/libcddb )
	flac? ( media-libs/flac )
	ffmpeg? ( virtual/ffmpeg )
	ifp? ( media-libs/libifp )
	jack? ( media-sound/jack-audio-connection-kit )
	lame? ( media-sound/lame )
	libsamplerate? ( media-libs/libsamplerate )
	lua? ( dev-lang/lua )
	mac? ( media-sound/mac )
	modplug? ( media-libs/libmodplug )
	mp3? ( media-libs/libmad )
	musepack? ( >=media-sound/musepack-tools-444 )
	pulseaudio? ( media-sound/pulseaudio )
	sndfile? ( media-libs/libsndfile )
	speex? ( media-libs/speex media-libs/liboggz )
	vorbis? ( media-libs/libvorbis )
	wavpack? ( media-sound/wavpack )
	x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	ladspa? ( media-libs/liblrdf )
	dev-libs/libxml2
	dev-util/pkgconfig"

S=${WORKDIR}/${PN}-${MY_PV}

src_configure() {
	econf \
		$(use_with alsa) \
		$(use_with cdda) \
		$(use_with cddb) \
		$(use_enable debug) \
		$(use_with flac) \
		$(use_with ffmpeg lavc) \
		$(use_with ifp) \
		$(use_with jack) \
		$(use_with ladspa) \
		$(use_with lame) \
		$(use_with libsamplerate src) \
		$(use_with lua) \
		$(use_with mac) \
		$(use_with modplug mod) \
		$(use_with mp3 mpeg) \
		$(use_with musepack mpc) \
		$(use_with oss) \
		$(use_with podcast) \
		$(use_with pulseaudio pulse) \
		$(use_with sndfile) \
		$(use_with speex) \
		$(use_with systray) \
		$(use_with vorbis ogg) \
		$(use_with vorbis vorbisenc) \
		$(use_with wavpack) \
		--with-loop
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc AUTHORS README ChangeLog || die
	newicon src/img/icon_64.png aqualung.png || die
	make_desktop_entry aqualung Aqualung
}

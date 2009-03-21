# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/aqualung/aqualung-0.9_beta10.ebuild,v 1.1 2009/03/21 11:10:35 yngwin Exp $

EAPI="1"
inherit eutils versionator

MY_PV="$(delete_version_separator 2)"
MY_PV="${MY_PV/_p/.}"

DESCRIPTION="A music player for a wide range of formats designed for gapless playback"
HOMEPAGE="http://aqualung.factorial.hu/"
SRC_URI="mirror://sourceforge/aqualung/${PN}-${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE="sndfile modplug mp3 vorbis speex flac musepack wavpack ffmpeg taglib ladspa
	cddb cdda ifp jack lua alsa oss lame systray debug"
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
	taglib? ( media-libs/taglib )
	cdda? ( dev-libs/libcdio )
	ifp? ( media-libs/libifp )
	lua? ( dev-lang/lua )
	media-libs/libsamplerate
	x11-libs/gtk+:2"

DEPEND="ladspa? ( media-libs/liblrdf )
	dev-util/pkgconfig
	dev-libs/libxml2
	media-libs/raptor
	${RDEPEND}"

S="${WORKDIR}/${PN}-${MY_PV}"

src_compile() {
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
		$(use_with taglib metadata) \
		$(use_with cdda) \
		$(use_with lua) \
		$(use_with ifp) \
		$(use_enable debug) \
		--with-loop \
		|| die "econf failed"

	emake || die "make failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "make install failed"
	dodoc AUTHORS README
	newicon src/img/icon_64.png aqualung.png
	make_desktop_entry aqualung Aqualung
}

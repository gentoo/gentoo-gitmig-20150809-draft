# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/aqualung/aqualung-0.9_beta9_p1.ebuild,v 1.1 2008/04/15 03:05:05 yngwin Exp $

inherit eutils autotools versionator

MY_PV="$(delete_version_separator 2)"
MY_PV="${MY_PV/_p/.}"

DESCRIPTION="A music player for a wide range of formats designed for gapless playback"
HOMEPAGE="http://aqualung.factorial.hu/"
SRC_URI="mirror://sourceforge/aqualung/${PN}-${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE="sndfile modplug mp3 vorbis speex flac musepack wavpack ffmpeg taglib ladspa
	cddb cdda jack alsa oss lame loop-playback systray debug"
KEYWORDS="~amd64 ~x86"

RDEPEND="vorbis? ( >=media-libs/libvorbis-1.0 )
	sndfile? ( >=media-libs/libsndfile-1.0.12 )
	flac? ( media-libs/flac )
	modplug? ( media-libs/libmodplug )
	alsa? ( virtual/alsa )
	mp3? ( media-libs/libmad )
	lame? ( media-sound/lame )
	musepack? ( media-libs/libmpcdec )
	ffmpeg? ( media-video/ffmpeg )
	speex? ( media-libs/speex media-libs/liboggz )
	wavpack? ( >=media-sound/wavpack-4.40.0 )
	cddb? ( !amd64? ( >=media-libs/libcddb-1.2.1 ) )
	cddb? ( amd64? ( >=media-libs/libcddb-1.3.0 ) )
	jack? ( media-sound/jack-audio-connection-kit )
	taglib? ( >=media-libs/taglib-1.4 )
	cdda? ( dev-libs/libcdio )
	systray? ( >=x11-libs/gtk+-2.10 )
	loop-playback? ( >=x11-libs/gtk+-2.8 )
	media-libs/libsamplerate
	>=x11-libs/gtk+-2.6"

DEPEND="ladspa? ( >=media-libs/liblrdf-0.4.0 )
	>=dev-util/pkgconfig-0.9.0
	dev-libs/libxml2
	media-libs/raptor
	${RDEPEND}"

S="${WORKDIR}/${PN}-${MY_PV}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/new-ffmpeg-headers.patch
}

src_compile() {
	econf \
		$(use_with alsa) \
		$(use_with oss) \
		$(use_with jack) \
		$(use_with flac) \
		$(use_with vorbis ogg) \
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
		$(use_with loop-playback loop) \
		$(use_enable debug) \
		|| die "econf failed"

	emake || die "make failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "make install failed"
	dodoc AUTHORS README
	newicon src/img/icon_64.png aqualung.png
	make_desktop_entry aqualung Aqualung
}

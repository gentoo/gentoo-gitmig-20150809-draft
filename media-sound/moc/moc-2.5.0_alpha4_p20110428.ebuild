# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/moc/moc-2.5.0_alpha4_p20110428.ebuild,v 1.1 2011/04/28 18:04:37 scarabeus Exp $

EAPI=4

inherit autotools

DESCRIPTION="Music On Console - ncurses interface for playing audio files"
HOMEPAGE="http://moc.daper.net"
SRC_URI="http://dev.gentoo.org/~scarabeus/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="oss alsa aac jack mad vorbis flac wavpack sndfile modplug musepack
timidity sid ffmpeg speex libsamplerate curl debug"

# libtool is used to load plugins so it is RUNTIME dependency
RDEPEND=">=sys-libs/db-4
	sys-devel/libtool
	alsa? ( media-libs/alsa-lib )
	aac? ( media-libs/faad2 )
	jack? ( media-sound/jack-audio-connection-kit )
	mad? ( media-libs/libmad sys-libs/zlib media-libs/libid3tag )
	vorbis? ( >=media-libs/libvorbis-1 )
	flac? ( media-libs/flac )
	wavpack? ( >=media-sound/wavpack-4.31 )
	sndfile? ( >=media-libs/libsndfile-1 )
	modplug? ( >=media-libs/libmodplug-0.7 )
	musepack? ( >=media-sound/musepack-tools-444-r1
		>=media-libs/taglib-1.3.1 )
	timidity? ( media-libs/libtimidity media-sound/timidity++ )
	sid? ( >=media-libs/libsidplay-2 )
	ffmpeg? ( virtual/ffmpeg )
	speex? ( >=media-libs/speex-1 )
	libsamplerate? ( >=media-libs/libsamplerate-0.1 )
	curl? ( >=net-misc/curl-7.12.2 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	eautoreconf
}

src_configure() {
	econf \
		--docdir="${EPREFIX}/usr/share/doc/${PF}" \
		--without-rcc \
		$(use_with alsa) \
		$(use_with oss) \
		$(use_with aac) \
		$(use_with jack) \
		$(use_with mad mp3) \
		$(use_with musepack) \
		$(use_with vorbis) \
		$(use_with flac) \
		$(use_with wavpack) \
		$(use_with sndfile) \
		$(use_with modplug) \
		$(use_with timidity) \
		$(use_with sid sidplay2) \
		$(use_with ffmpeg) \
		$(use_with speex) \
		$(use_with libsamplerate samplerate) \
		$(use_with curl) \
		$(use_enable debug)
}

# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/moc/moc-2.5.0_alpha3-r2.ebuild,v 1.8 2009/05/11 18:03:30 ssuominen Exp $

EAPI=2
inherit autotools eutils

MY_P=${P/_/-}
MOC_M4_VER=1

DESCRIPTION="Music On Console - ncurses interface for playing audio files"
HOMEPAGE="http://moc.daper.net"
SRC_URI="ftp://ftp.daper.net/pub/soft/${PN}/unstable/${MY_P}.tar.bz2
	mirror://gentoo/${PN}-m4-${MOC_M4_VER}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE="alsa aac jack mad musepack vorbis flac wavpack sndfile modplug timidity sid ffmpeg speex libsamplerate curl debug"

RDEPEND="media-libs/libao
	alsa? ( media-libs/alsa-lib )
	aac? ( media-libs/faad2 )
	jack? ( media-sound/jack-audio-connection-kit )
	mad? ( media-libs/libmad sys-libs/zlib media-libs/libid3tag )
	musepack? ( media-libs/libmpcdec >=media-libs/taglib-1.3 )
	vorbis? ( >=media-libs/libvorbis-1 )
	flac? ( media-libs/flac )
	wavpack? ( >=media-sound/wavpack-4.31 )
	sndfile? ( >=media-libs/libsndfile-1 )
	modplug? ( >=media-libs/libmodplug-0.7 )
	timidity? ( media-libs/libtimidity media-sound/timidity++ )
	sid? ( >=media-libs/libsidplay-2 )
	ffmpeg? ( media-video/ffmpeg )
	speex? ( >=media-libs/speex-1 )
	libsamplerate? ( >=media-libs/libsamplerate-0.1 )
	curl? ( >=net-misc/curl-7.12.2 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}"/${P}-faad2.patch \
		"${FILESDIR}"/${P}-ffmpegheaders.patch \
		"${FILESDIR}"/${P}-libtool22.patch \
		"${FILESDIR}"/${P}-fix_default_configuration_layout.patch
	cp -f "${WORKDIR}"/m4/* m4/
	AT_M4DIR="m4" eautoreconf
}

src_configure() {
	econf \
		--without-rcc \
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

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO *.example
	rm -rf "${D}"/usr/share/doc/${PN}
}

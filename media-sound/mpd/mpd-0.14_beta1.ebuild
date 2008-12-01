# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mpd/mpd-0.14_beta1.ebuild,v 1.2 2008/12/01 20:09:27 angelos Exp $

EAPI=1

inherit flag-o-matic eutils

DESCRIPTION="The Music Player Daemon (mpd)"
HOMEPAGE="http://www.musicpd.org"
SRC_URI="mirror://sourceforge/musicpd/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="aac alsa ao audiofile curl ffmpeg flac icecast id3 ipv6 jack lame libsamplerate mad mikmod musepack ogg oss pulseaudio sysvipc unicode vorbis wavpack zeroconf"

DEPEND="!sys-cluster/mpich2
	>=dev-libs/glib-2.4:2
	aac? ( >=media-libs/faad2-2.0_rc2 )
	alsa? ( media-sound/alsa-utils )
	ao? ( >=media-libs/libao-0.8.4 )
	audiofile? ( media-libs/audiofile )
	curl? ( net-misc/curl )
	ffmpeg? ( media-video/ffmpeg )
	flac? ( media-libs/flac )
	icecast? ( lame? ( media-libs/libshout ) )
	id3? ( media-libs/libid3tag )
	jack? ( media-sound/jack-audio-connection-kit )
	lame? ( icecast? ( media-sound/lame ) )
	libsamplerate? ( media-libs/libsamplerate )
	mad? ( media-libs/libmad )
	mikmod? ( media-libs/libmikmod )
	musepack? ( media-libs/libmpcdec )
	ogg? ( media-libs/libogg )
	pulseaudio? ( media-sound/pulseaudio )
	zeroconf? ( net-dns/avahi )
	vorbis? ( media-libs/libvorbis
		icecast? ( media-libs/libshout ) )
	wavpack? ( media-sound/wavpack )"

S="${WORKDIR}/${PN}-${PV/_/~}"

pkg_setup() {
	if use ogg && use flac && ! built_with_use media-libs/flac ogg; then
		eerror "To be able to play OggFlac files you need to build"
		eerror "media-libs/flac with +ogg, to build libOggFLAC."
		die "Missing libOggFLAC library."
	fi

	if use icecast && ! use lame && ! use vorbis; then
		ewarn "USE=icecast enabled but lame and vorbis disabled,"
		ewarn "disabling icecast"
	fi

	enewuser mpd "" "" "/var/lib/mpd" audio
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/mpdconf.patch
}

src_compile() {
	local myconf

	myconf=""

	if use zeroconf; then
		myconf+=" --with-zeroconf=avahi"
	else
		myconf+=" --with-zeroconf=no"
	fi

	if use ogg && use flac; then
		myconf=" --enable-oggflac --enable-libOggFLACtest"
	else
		myconf=" --disable-oggflac --disable-libOggFLACtest"
	fi

	if use icecast; then
		myconf+=" $(use_enable vorbis shout_ogg) $(use_enable lame shout_mp3)"
	else
		myconf+=" --disable-shout_ogg --disable-shout_mp3"
	fi

	append-lfs-flags

	econf \
		$(use_enable aac) \
		$(use_enable alsa) \
		$(use_enable ao) \
		$(use_enable audiofile) \
		$(use_enable curl) \
		$(use_enable ffmpeg) \
		$(use_enable flac) \
		$(use_enable id3) \
		$(use_enable ipv6) \
		$(use_enable jack) \
		$(use_enable libsamplerate lsr) \
		$(use_enable mad mp3) \
		$(use_enable mikmod mod) \
		$(use_enable musepack mpc) \
		$(use_enable oss) \
		$(use_enable pulseaudio pulse) \
		$(use_enable sysvipc un) \
		$(use_enable vorbis oggvorbis) \
		$(use_enable wavpack) \
		${myconf}

	emake || die "emake failed"
}

src_install() {
	dodir /var/run/mpd
	fowners mpd:audio /var/run/mpd
	fperms 750 /var/run/mpd
	keepdir /var/run/mpd

	emake install DESTDIR="${D}" || die
	rm -rf "${D}"/usr/share/doc/mpd/
	dodoc AUTHORS NEWS README TODO UPGRADING
	dodoc doc/mpdconf.example

	insinto /etc
	newins doc/mpdconf.example mpd.conf

	newinitd "${FILESDIR}"/mpd.rc mpd

	if use unicode; then
		dosed 's:^#filesystem_charset.*$:filesystem_charset "UTF-8":' /etc/mpd.conf
	fi
	diropts -m0755 -o mpd -g audio
	dodir /var/lib/mpd/music
	keepdir /var/lib/mpd/music
	dodir /var/lib/mpd/playlists
	keepdir /var/lib/mpd/playlists
	dodir /var/log/mpd
	keepdir /var/log/mpd

	use alsa && \
		dosed 's:need :need alsasound :' /etc/init.d/mpd
}

pkg_postinst() {
	elog "If you will be starting mpd via /etc/init.d/mpd initscript, please make"
	elog "sure that MPD's pid_file is set to /var/run/mpd/mpd.pid."

	# also change the homedir if the user has existed before
	usermod -d "/var/lib/mpd" mpd
}

# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mpd/mpd-0.15_alpha1.ebuild,v 1.1 2009/04/14 13:14:09 angelos Exp $

EAPI=2

inherit flag-o-matic eutils

DESCRIPTION="The Music Player Daemon (mpd)"
HOMEPAGE="http://www.musicpd.org"
SRC_URI="mirror://sourceforge/musicpd/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="aac +alsa ao audiofile bzip2 cdio +curl debug doc +fifo +ffmpeg flac fluidsynth gprof http-stream icecast +id3 ipv6 jack lame lastfmradio libmms libsamplerate +mad mikmod modplug musepack ogg oss pipe pulseaudio sid sqlite unicode vorbis wavpack zeroconf zip"

RDEPEND="!sys-cluster/mpich2
	>=dev-libs/glib-2.4:2
	aac? ( >=media-libs/faad2-2.0_rc2 )
	alsa? ( media-sound/alsa-utils )
	ao? ( >=media-libs/libao-0.8.4 )
	audiofile? ( media-libs/audiofile )
	bzip2? ( app-arch/bzip2 )
	cdio? ( dev-libs/libcdio )
	curl? ( net-misc/curl )
	ffmpeg? ( media-video/ffmpeg )
	flac? ( media-libs/flac
		ogg? ( media-libs/flac[ogg] ) )
	fluidsynth? ( media-sound/fluidsynth )
	icecast? ( lame? ( media-libs/libshout )
		vorbis? ( media-libs/libshout ) )
	id3? ( media-libs/libid3tag )
	jack? ( media-sound/jack-audio-connection-kit )
	lame? ( icecast? ( media-sound/lame ) )
	libmms? ( media-libs/libmms )
	libsamplerate? ( media-libs/libsamplerate )
	mad? ( media-libs/libmad )
	mikmod? ( media-libs/libmikmod )
	modplug? ( media-libs/libmodplug )
	musepack? ( media-libs/libmpcdec )
	ogg? ( media-libs/libogg )
	pulseaudio? ( media-sound/pulseaudio )
	sid? ( media-libs/libsidplay:2 )
	sqlite? ( dev-db/sqlite:3 )
	vorbis? ( media-libs/libvorbis )
	wavpack? ( media-sound/wavpack )
	zeroconf? ( net-dns/avahi )
	zip? ( dev-libs/zziplib )"
	#midi? ( media-libs/wildmidi )
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( app-doc/doxygen
		app-text/xmlto )"

pkg_setup() {
	if use icecast || use http; then
		if ! use lame && ! use vorbis; then
			eerror "Icecast or http output streaming is enabled,"
			eerror "but there is no encoding enabled (lame and"
			eerror "vorbis are both disabled)."
		fi
	fi

	if use lastfmradio && ! use curl; then
		eerror "Cannot enable lastfmradio without curl."
	fi

	if use fluidsynth; then
		ewarn "Use of fluidsynth USE is highly discouraged by upstream."
		#ewarn "Use wildmidi unless you know better."
	fi

	enewuser mpd "" "" "/var/lib/mpd" audio
}

src_prepare() {
	cp doc/mpdconf.example doc/mpdconf.dist
	epatch "${FILESDIR}"/mpdconf1.patch
}

src_configure() {
	if use icecast || use http; then
		myconf="$(use_enable lame lame-encoder) $(use_enable vorbis vorbis-encoder)"
	else
		myconf="--disable-lame-encoder --disable-vorbis-encoder"
	fi

	append-lfs-flags

	econf \
		$(use_enable aac) \
		$(use_enable alsa) \
		$(use_enable ao) \
		$(use_enable audiofile) \
		$(use_enable bzip2) \
		$(use_enable curl) \
		$(use_enable cdio iso9660) \
		$(use_enable debug) \
		$(use_enable doc documentation) \
		$(use_enable fluidsynth) \
		$(use_enable fifo) \
		$(use_enable ffmpeg) \
		$(use_enable flac) \
		$(use_enable gprof) \
		$(use_enable http httpd-output) \
		$(use_enable id3) \
		$(use_enable ipv6) \
		$(use_enable jack) \
		$(use_enable lastfmradio lastfm) \
		$(use_enable modplug) \
		$(use_enable libmms mms) \
		$(use_enable libsamplerate lsr) \
		$(use_enable mad) \
		$(use_enable mikmod) \
		$(use_enable musepack mpc) \
		$(use_enable oss) \
		$(use_enable pipe pipe-output) \
		$(use_enable pulseaudio pulse) \
		$(use_enable sid sidplay) \
		$(use_enable sqlite sqlite) \
		$(use_enable vorbis) \
		$(use_enable wavpack) \
		$(use_enable zip) \
		$(use_with zeroconf zeroconf avahi) \
		--enable-tcp \
		--enable-un \
		${myconf}
		#$(use_enable midi wildmidi) \
}

src_install() {
	dodir /var/run/mpd
	fowners mpd:audio /var/run/mpd
	fperms 750 /var/run/mpd
	keepdir /var/run/mpd

	emake DESTDIR="${D}" install || die "emake install failed"
	rm -rf "${D}"/usr/share/doc/mpd/

	dodoc AUTHORS NEWS README TODO UPGRADING
	dodoc doc/mpdconf.dist
	use doc && dohtml doc/protocol.html

	insinto /etc
	newins doc/mpdconf.example mpd.conf

	newinitd "${FILESDIR}"/mpd.rc mpd

	if use unicode; then
		dosed 's:^#filesystem_charset.*$:filesystem_charset "UTF-8":' \
			/etc/mpd.conf || die "dosed failed"
	fi

	diropts -m0755 -o mpd -g audio
	dodir /var/lib/mpd
	keepdir /var/lib/mpd
	dodir /var/lib/mpd/music
	keepdir /var/lib/mpd/music
	dodir /var/lib/mpd/playlists
	keepdir /var/lib/mpd/playlists
	dodir /var/log/mpd
	keepdir /var/log/mpd

	if use alsa; then
		dosed 's:need :need alsasound :' /etc/init.d/mpd || die "dosed failed"
	fi
}

pkg_postinst() {
	elog "If you will be starting mpd via /etc/init.d/mpd, please make"
	elog "sure that MPD's pid_file is set to /var/run/mpd/mpd.pid."

	# also change the homedir if the user has existed before
	usermod -d "/var/lib/mpd" mpd
}

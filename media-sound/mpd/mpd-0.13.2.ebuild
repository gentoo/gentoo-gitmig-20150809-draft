# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mpd/mpd-0.13.2.ebuild,v 1.11 2009/04/14 18:06:00 angelos Exp $

EAPI="2"

inherit eutils

DESCRIPTION="The Music Player Daemon (mpd)"
HOMEPAGE="http://www.musicpd.org"
SRC_URI="http://www.musicpd.org/uploads/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm hppa ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE="aac alsa ao audiofile avahi flac icecast iconv ipv6 jack libsamplerate mp3 mikmod musepack ogg oss pulseaudio unicode vorbis"

DEPEND="!sys-cluster/mpich2
	aac? ( >=media-libs/faad2-2.0_rc2 )
	alsa? ( media-sound/alsa-utils )
	ao? ( >=media-libs/libao-0.8.4 )
	audiofile? ( media-libs/audiofile )
	avahi? ( net-dns/avahi )
	flac? ( media-libs/flac
		ogg? ( media-libs/flac[ogg] ) )
	icecast? ( media-libs/libshout )
	iconv? ( virtual/libiconv )
	jack? ( media-sound/jack-audio-connection-kit )
	libsamplerate? ( media-libs/libsamplerate )
	mp3? ( media-libs/libmad
	       media-libs/libid3tag )
	mikmod? ( media-libs/libmikmod )
	musepack? ( media-libs/libmpcdec )
	ogg? ( media-libs/libogg )
	pulseaudio? ( media-sound/pulseaudio )
	vorbis? ( media-libs/libvorbis )"

pkg_setup() {
	enewuser mpd "" "" "/var/lib/mpd" audio
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PV}-mpdconf.patch || die "epatch for config file failed"
}

src_compile() {
	local myconf

	myconf=""

	if use avahi; then
		myconf="${myconf} --with-zeroconf=avahi"
	else
		myconf="${myconf} --with-zeroconf=no"
	fi

	if use ogg && use flac; then
		myconf="${myconf} --enable-oggflac --enable-libOggFLACtest"
	else
		myconf="${myconf} --disable-oggflac --disable-libOggFLACtest"
	fi

	econf \
		$(use_enable aac) \
		$(use_enable alsa) \
		$(use_enable alsa alsatest) \
		$(use_enable ao) \
		$(use_enable ao aotest) \
		$(use_enable audiofile) \
		$(use_enable audiofile audiofiletest) \
		$(use_enable flac) \
		$(use_enable flac libFLACtest) \
		$(use_enable icecast shout) \
		$(use_enable iconv) \
		$(use_enable ipv6) \
		$(use_enable jack) \
		$(use_enable libsamplerate lsr) \
		$(use_enable mp3) \
		$(use_enable mp3 id3) \
		$(use_enable mikmod mod) \
		$(use_enable mikmod libmikmodtest) \
		$(use_enable musepack mpc) \
		$(use_enable oss) \
		$(use_enable ogg oggtest) \
		$(use_enable pulseaudio pulse) \
		$(use_enable vorbis oggvorbis) \
		$(use_enable vorbis vorbistest) \
		${myconf} || die "could not configure"

	emake || die "emake failed"
}

src_install() {
	dodir /var/run/mpd
	fowners mpd:audio /var/run/mpd
	fperms 750 /var/run/mpd
	keepdir /var/run/mpd

	emake install DESTDIR="${D}" || die
	rm -rf "${D}"/usr/share/doc/mpd/
	dodoc AUTHORS ChangeLog INSTALL README TODO UPGRADING
	dodoc doc/COMMANDS doc/mpdconf.example

	insinto /etc
	newins doc/mpdconf.example mpd.conf

	newinitd "${FILESDIR}"/mpd.rc mpd

	if use unicode; then
		dosed 's:^#filesystem_charset.*$:filesystem_charset "UTF-8":' /etc/mpd.conf
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

	use alsa && \
		dosed 's:need :need alsasound :' /etc/init.d/mpd
}

pkg_postinst() {
	elog "If you will be starting mpd via /etc/init.d/mpd initscript, please make"
	elog "sure that MPD's pid_file is set to /var/run/mpd/mpd.pid."

	# also change the homedir if the user has existed before
	usermod -d "/var/lib/mpd" mpd
}

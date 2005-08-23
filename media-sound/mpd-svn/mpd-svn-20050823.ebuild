# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mpd-svn/mpd-svn-20050823.ebuild,v 1.1 2005/08/23 15:39:15 ticho Exp $

inherit eutils

DESCRIPTION="A development version of Music Player Daemon (mpd)"
HOMEPAGE="http://www.musicpd.org"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="aac alsa ao audiofile flac icecast ipv6 mad mikmod musepack ogg unicode"

DEPEND="dev-util/gperf
	!media-sound/mpd
	sys-libs/zlib
	aac? ( >=media-libs/faad2-2.0_rc2 )
	alsa? ( media-libs/alsa-lib )
	ao? ( >=media-libs/libao-0.8.4 )
	audiofile? ( media-libs/audiofile )
	flac? ( >=media-libs/flac-1.1.0 )
	icecast? ( media-libs/libshout )
	mad? ( media-libs/libmad
	       media-libs/libid3tag )
	mikmod? ( media-libs/libmikmod )
	musepack? ( >=media-libs/libmusepack-1.1 )
	ogg? ( media-libs/libogg
		media-libs/libvorbis )"

pkg_setup() {
	enewuser mpd '' '' '' audio || die "problem adding user mpd"
}

src_compile() {
	econf \
		$(use_enable aac) \
		$(use_enable ao) \
		$(use_enable audiofile) \
		$(use_enable audiofile audiofiletest) \
		$(use_enable flac libFLACtest) \
		$(use_enable flac) \
		$(use_enable icecast shout) \
		$(use_enable ipv6) \
		$(use_enable !mad mpd-mad) \
		$(use_enable !mad id3tag) \
		$(use_enable mikmod libmikmodtest) \
		$(use_enable mikmod mod) \
		$(use_enable musepack mpc) \
		$(use_enable ogg) \
		$(use_enable ogg oggtest) \
		$(use_enable ogg vorbistest) \
		|| die "could not configure"

	emake || die "emake failed"
}

src_install() {
	dodir /var/run/mpd
	fowners mpd:audio /var/run/mpd
	fperms 750 /var/run/mpd
	keepdir /var/run/mpd

	emake install DESTDIR=${D} || die
	rm -rf ${D}/usr/share/doc/mpd/
	dodoc ChangeLog INSTALL README TODO UPGRADING
	dodoc doc/COMMANDS doc/mpdconf.example

	insinto /etc
	newins doc/mpdconf.example mpd.conf

	exeinto /etc/init.d
	newexe ${FILESDIR}/mpd.pidfile.rc6 mpd

	if use unicode; then
		dosed 's:^#filesystem_charset.*$:filesystem_charset "UTF-8":' /etc/mpd.conf
	fi
	dosed 's:^#user.*$:user "mpd":' /etc/mpd.conf
	dosed 's:^#bind.*$:bind_to_address "localhost":' /etc/mpd.conf
	dosed 's:^port.*$:port "6600":' /etc/mpd.conf
	dosed 's:^music_directory.*$:music_directory "/usr/share/mpd/music":' /etc/mpd.conf
	dosed 's:^playlist_directory.*$:playlist_directory "/usr/share/mpd/playlists":' /etc/mpd.conf
	dosed 's:^log_file.*$:log_file "/var/log/mpd.log":' /etc/mpd.conf
	dosed 's:^error_file.*$:error_file "/var/log/mpd.error.log":' /etc/mpd.conf
	dosed 's:^pid_file.*$:pid_file "/var/run/mpd/mpd.pid":' /etc/mpd.conf
	diropts -m0755 -o mpd -g audio
	dodir /usr/share/mpd/music
	keepdir /usr/share/mpd/music
	dodir /usr/share/mpd/playlists
	keepdir /usr/share/mpd/playlists
	dodir /usr/share/mpd/
	insinto /var/log
	touch ${T}/blah
	insopts -m0640 -o mpd -g audio
	newins ${T}/blah mpd.log
	newins ${T}/blah mpd.error.log

	use alsa && \
		dosed 's:need :need alsasound :' /etc/init.d/mpd
}

pkg_postinst() {
	echo
	einfo "The default config now binds the daemon strictly to localhost,"
	einfo "rather than to all available IPs."
	echo
	if use ao; then
		einfo "libao prior to 0.8.4 has issues with the ALSA drivers"
		einfo "please refer to the FAQ"
		einfo "http://www.musicpd.org/wiki/moin.cgi/MpdFAQ if you are"
		einfo "having problems."
		echo
	else
		draw_line
		ewarn "As you're not using libao for audio output, you need to"
		ewarn "adjust audio_output sections in /etc/mpd.conf to use"
		ewarn "ALSA or OSS. See"
		ewarn "/usr/share/doc/${PF}/mpdconf.example.gz."
		draw_line
		echo
	fi
	einfo "Please make sure that MPD's pid_file is set to /var/run/mpd/mpd.pid."
	echo
	ewarn "Note that this is just a development version of Music Player Daemon,"
	ewarn "so if you want to report any bug to MPD developers, please state this fact in"
	ewarn "your bug report, as well as the fact that you used a ${P} Gentoo ebuild."
	echo
}

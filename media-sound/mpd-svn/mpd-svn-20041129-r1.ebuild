# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mpd-svn/mpd-svn-20041129-r1.ebuild,v 1.3 2004/12/07 17:36:20 ticho Exp $

IUSE="oggvorbis mad aac audiofile ipv6 flac mikmod alsa unicode"

inherit eutils

DESCRIPTION="Music Player Daemon (mpd)"
HOMEPAGE="http://www.musicpd.org"
SRC_URI="http://dev.gentoo.org/~ticho/portage/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="!media-sound/mpd
	oggvorbis? ( media-libs/libvorbis )
	mad? ( media-libs/libmad
	       media-libs/libid3tag )
	aac? ( >=media-libs/faad2-2.0_rc2 )
	audiofile? ( media-libs/audiofile )
	flac? ( >=media-libs/flac-1.1.0 )
	mikmod? ( media-libs/libmikmod )
	alsa? ( media-libs/alsa-lib )
	>=media-libs/libao-0.8.4
	sys-libs/zlib
	dev-util/gperf"

pkg_setup() {
	enewuser mpd '' '' '' audio || die "problem adding user mpd"
}

src_compile() {
	econf `use_enable aac` \
		`use_enable oggvorbis ogg` \
		`use_enable oggvorbis oggtest` \
		`use_enable oggvorbis vorbistest` \
		`use_enable audiofile` \
		`use_enable audiofile audiofiletest` \
		`use_enable ipv6` \
		`use_enable flac libFLACtest` \
		`use_enable flac` \
		`use_enable !mad mpd-mad` \
		`use_enable !mad id3tag` \
		`use_enable mikmod libmikmodtest` \
		`use_enable mikmod mod` || die "could not configure"

	emake || die "emake failed"
}

src_install() {
	emake install DESTDIR=${D} || die
	rm -rf ${D}/usr/share/doc/mpd/
	dodoc COPYING ChangeLog INSTALL README TODO UPGRADING
	dodoc doc/COMMANDS doc/mpdconf.example

	insinto /etc
	newins doc/mpdconf.example mpd.conf

	exeinto /etc/init.d
	newexe ${FILESDIR}/mpd.rc6 mpd

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
}

pkg_postinst() {
	einfo "libao prior to 0.8.4 has issues with the ALSA drivers"
	einfo "please refer to the FAQ"
	einfo "http://www.musicpd.org/wiki/moin.cgi/MpdFAQ if you are having problems."
	einfo
	einfo "The default config now binds the daemon strictly to localhost, rather then all available IPs."
	echo
	ewarn "Note that this is just a development version of Music Player Daemon,"
	ewarn "so if you want to report any bug, please state this fact in your"
	ewarn "report, as well as the fact that you used a ${P} Gentoo ebuild."
}

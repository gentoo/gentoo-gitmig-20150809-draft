# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mpd/mpd-0.11.4-r1.ebuild,v 1.2 2004/10/19 06:19:37 eradicator Exp $

inherit eutils

IUSE="oggvorbis mad aac audiofile ipv6 flac mikmod alsa"

DESCRIPTION="Music Player Daemon (mpd)"
SRC_URI="http://mercury.chem.pitt.edu/~shank/${P}.tar.gz"
HOMEPAGE="http://www.musicpd.org"

KEYWORDS="x86 amd64 sparc ~ppc"
SLOT="0"
LICENSE="GPL-2"

DEPEND="oggvorbis? ( media-libs/libvorbis )
	mad? ( media-libs/libmad
	       media-libs/libid3tag )
	aac? ( >=media-libs/faad2-2.0_rc2 )
	audiofile? ( media-libs/audiofile )
	flac? ( >=media-libs/flac-1.1.0 )
	mikmod? ( media-libs/libmikmod )
	alsa? ( media-libs/alsa-lib )
	>=media-libs/libao-0.8.4
	sys-libs/zlib"

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

	dosed 's:^#user.*$:user "mpd":' /etc/mpd.conf
	dosed 's:^#bind.*$:bind_to_address "localhost":' /etc/mpd.conf
	dosed 's:^port.*$:port "6600":' /etc/mpd.conf
	dosed 's:^music_directory.*$:music_directory "/usr/share/mpd/music":' /etc/mpd.conf
	dosed 's:^playlist_directory.*$:playlist_directory "/usr/share/mpd/playlists":' /etc/mpd.conf
	dosed 's:^log_file.*$:log_file "/var/log/mpd.log":' /etc/mpd.conf
	dosed 's:^error_file.*$:error_file "/var/log/mpd.error.log":' /etc/mpd.conf
}

pkg_preinst() {
	enewuser mpd '' '' '' audio || die "problem adding user mpd"
}

pkg_postinst() {
	einfo "libao prior to 0.8.4 has issues with the ALSA drivers"
	einfo "please refer to the FAQ"
	einfo "http://musicpd.sourceforge.net/faq.php if you are having problems."
	einfo
	einfo "The default config now binds the daemon strictly to localhost, rather then all available IPs."
}

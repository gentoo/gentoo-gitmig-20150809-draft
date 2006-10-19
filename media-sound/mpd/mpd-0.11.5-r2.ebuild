# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mpd/mpd-0.11.5-r2.ebuild,v 1.13 2006/10/19 22:43:09 ticho Exp $

inherit eutils

DESCRIPTION="Music Player Daemon (mpd)"
HOMEPAGE="http://www.musicpd.org"
SRC_URI="http://mercury.chem.pitt.edu/~shank/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ppc sparc x86"
IUSE="aac alsa audiofile flac ipv6 mad mikmod unicode vorbis"

DEPEND=">=media-libs/libao-0.8.4
	!media-sound/mpd-svn
	!sys-cluster/mpich2
	sys-libs/zlib
	aac? ( >=media-libs/faad2-2.0_rc2 )
	alsa? ( media-sound/alsa-utils )
	audiofile? ( media-libs/audiofile )
	flac? ( ~media-libs/flac-1.1.2 )
	mad? ( media-libs/libmad
	       media-libs/libid3tag )
	mikmod? ( media-libs/libmikmod )
	vorbis? ( media-libs/libvorbis )"

upgrade_warning() {
	echo
	ewarn "This package now correctly uses 'vorbis' USE flag, instead of 'ogg'."
	ewarn "See http://bugs.gentoo.org/101877 for details."
	echo
	ewarn "Home directory of user mpd, as well as default locations in mpd.conf have"
	ewarn "been changed to /var/lib/mpd, please bear that in mind while updating"
	ewarn "your mpd.conf file."
	echo
}

pkg_setup() {
	upgrade_warning
	epause 7
	enewuser mpd '' '' "/var/lib/mpd" audio || die "problem adding user mpd"

	# also change the homedir if the user has existed before
	usermod -d "/var/lib/mpd" mpd || die "usermod failed"
}

src_compile() {
	econf \
		$(use_enable aac) \
		$(use_enable audiofile) \
		$(use_enable audiofile audiofiletest) \
		$(use_enable flac libFLACtest) \
		$(use_enable flac) \
		$(use_enable ipv6) \
		$(use_enable !mad mpd-mad) \
		$(use_enable !mad id3tag) \
		$(use_enable mikmod libmikmodtest) \
		$(use_enable mikmod mod) \
		$(use_enable vorbis ogg) \
		$(use_enable vorbis oggtest) \
		$(use_enable vorbis vorbistest) \
		|| die "could not configure"

	emake || die "emake failed"
}

src_install() {
	make install DESTDIR="${D}" || die "make install failed"

	rm -rf "${D}"/usr/share/doc/mpd/
	dodoc ChangeLog README TODO UPGRADING
	dodoc doc/COMMANDS doc/mpdconf.example

	insinto /etc
	newins doc/mpdconf.example mpd.conf

	newinitd "${FILESDIR}"/mpd.rc6 mpd

	if use unicode; then
		dosed 's:^#filesystem_charset.*$:filesystem_charset "UTF-8":' /etc/mpd.conf
	fi
	dosed 's:^#user.*$:user "mpd":' /etc/mpd.conf
	dosed 's:^#bind.*$:bind_to_address "localhost":' /etc/mpd.conf
	dosed 's:^port.*$:port "6600":' /etc/mpd.conf
	dosed 's:^music_directory.*$:music_directory "/var/lib/mpd/music":' /etc/mpd.conf
	dosed 's:^playlist_directory.*$:playlist_directory "/var/lib/mpd/playlists":' /etc/mpd.conf
	dosed 's:^log_file.*$:log_file "/var/log/mpd.log":' /etc/mpd.conf
	dosed 's:^error_file.*$:error_file "/var/log/mpd.error.log":' /etc/mpd.conf
	dosed 's:^db_file.*:db_file "/var/lib/mpd/database":' /etc/mpd.conf
	dosed 's:^#state_file.*$:state_file "/var/lib/mpd/state":' /etc/mpd.conf

	diropts -m0755 -o mpd -g audio
	dodir /var/lib/mpd/music
	keepdir /var/lib/mpd/music
	dodir /var/lib/mpd/playlists
	keepdir /var/lib/mpd/playlists
	insinto /var/log
	touch ${T}/blah
	insopts -m0640 -o mpd -g audio
	newins ${T}/blah mpd.log
	newins ${T}/blah mpd.error.log

	use alsa && \
		dosed 's:need :need alsasound :' /etc/init.d/mpd
}

pkg_postinst() {
	upgrade_warning
}

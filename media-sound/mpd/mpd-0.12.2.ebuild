# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mpd/mpd-0.12.2.ebuild,v 1.1 2007/03/20 23:53:08 ticho Exp $

inherit eutils

DESCRIPTION="A development version of Music Player Daemon (mpd)"
HOMEPAGE="http://www.musicpd.org"
SRC_URI="http://musicpd.org/uploads/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="aac alsa ao audiofile flac icecast ipv6 mp3 mikmod mp3 musepack oss pulseaudio unicode vorbis"

DEPEND="dev-util/gperf
	!media-sound/mpd-svn
	!sys-cluster/mpich2
	sys-libs/zlib
	aac? ( >=media-libs/faad2-2.0_rc2 )
	alsa? ( media-sound/alsa-utils )
	ao? ( >=media-libs/libao-0.8.4 )
	audiofile? ( media-libs/audiofile )
	flac? ( ~media-libs/flac-1.1.2 )
	icecast? ( media-libs/libshout )
	mp3? ( media-libs/libmad
	       media-libs/libid3tag )
	mikmod? ( media-libs/libmikmod )
	musepack? ( media-libs/libmpcdec )
	pulseaudio? ( media-sound/pulseaudio )
	vorbis? ( media-libs/libvorbis )"

upgrade_warning() {
	echo
	ewarn "In 0.12, home directory of user mpd, as well as default locations in mpd.conf"
	ewarn "have been changed to /var/lib/mpd, please bear that in mind while updating"
	ewarn "your mpd.conf file."
	echo
	epause 5
}

pkg_setup() {
	upgrade_warning
	enewuser mpd '' '' "/var/lib/mpd" audio || die "problem adding user mpd"

	# also change the homedir if the user has existed before
	usermod -d "/var/lib/mpd" mpd
}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/mpd-${PV%.*}-conf.patch || die "epatch for config file
	failed"
}

src_compile() {
	econf \
		$(use_enable alsa) \
		$(use_enable alsa alsatest) \
		$(use_enable oss) \
		$(use_enable mp3) \
		$(use_enable aac) \
		$(use_enable ao) \
		$(use_enable ao aotest) \
		$(use_enable audiofile) \
		$(use_enable audiofile audiofiletest) \
		$(use_enable flac libFLACtest) \
		$(use_enable flac) \
		$(use_enable flac oggflac) \
		$(use_enable icecast shout) \
		$(use_enable ipv6) \
		$(use_enable mp3) \
		$(use_enable mp3 id3) \
		$(use_enable mikmod libmikmodtest) \
		$(use_enable mikmod mod) \
		$(use_enable musepack mpc) \
		$(use_enable pulseaudio pulse) \
		$(use_enable vorbis oggvorbis) \
		$(use_enable vorbis vorbistest) \
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
	newexe ${FILESDIR}/mpd-0.12.rc6 mpd

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
	upgrade_warning
	elog "If you are upgrading from 0.11.x, check the configuration file carefully,"
	elog "the format has changed. See the example config file installed as"
	elog "/usr/share/doc/${PF}/mpdconf.example.gz, and mpd.conf manual page."
	elog ""
	elog "Please make sure that MPD's pid_file is set to /var/run/mpd/mpd.pid."
}

# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mpd/mpd-0.10.2.ebuild,v 1.1 2004/03/25 16:08:07 mholzer Exp $

IUSE="oggvorbis mad"

DESCRIPTION="Music Player Daemon (mpd)"
SRC_URI="mirror://sourceforge/musicpd/${P}.tar.gz"
RESTRICT="nomirror"
HOMEPAGE="http://www.musicpd.org"

KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND="oggvorbis? ( media-libs/libvorbis )
	mad? ( media-sound/mad )
	>=media-libs/flac-1.1.0
	media-libs/libao
	sys-libs/zlib"

src_compile() {
	local myconf
	myconf=""

	use oggvorbis \
		|| myconf="${myconf} --disable-ogg  --disable-oggtest \
			--disable-vorbistest"
	use mad || myconf="${myconf} --enable-mpd-mad --enable-mpd-id3tag"

	econf ${myconf} || die "could not configure"

	emake || die "emake failed"
}

src_install() {
	emake install DESTDIR=${D} || die
	rm -rf ${D}/usr/share/doc/mpd/
	dodoc COPYING ChangeLog INSTALL README TODO UPGRADING
	dodoc doc/COMMANDS doc/mpdconf.example

	exeinto /etc/init.d
	newexe ${FILESDIR}/mpd.rc6 mpd
	insinto /etc/conf.d
	newins ${FILESDIR}/mpd.conf mpd
}

pkg_postinst() {
	einfo "libao has issues with the ALSA drivers, please refer to the FAQ"
	einfo "http://musicpd.sourceforge.net/faq.php"
	einfo
	einfo " You need to set PORT, MUSIC_DIR, PLAYLIST_DIR,"
	einfo " LOG_FILE and ERROR_FILE in /etc/conf.d/mpd"
}

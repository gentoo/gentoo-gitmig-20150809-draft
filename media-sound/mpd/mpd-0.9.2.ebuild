# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mpd/mpd-0.9.2.ebuild,v 1.3 2004/01/21 05:47:55 raker Exp $

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
	myconf="--with-gnu-ld"

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
}

pkg_postinst() {
	einfo "libao has issues with the ALSA drivers, please refer to the FAQ"
	einfo "http://musicpd.sourceforge.net/faq.php"
}

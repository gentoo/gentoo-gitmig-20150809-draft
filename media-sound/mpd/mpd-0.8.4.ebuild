# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mpd/mpd-0.8.4.ebuild,v 1.1 2003/08/14 04:28:36 g2boojum Exp $

IUSE="oggvorbis mad"

DESCRIPTION="Music Player Daemon (mpd)"
SRC_URI="http://mercury.chem.pitt.edu/~shank/${P}.tar.gz"
HOMEPAGE="http://musicpd.sourceforge.net/"

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
	dobin mpd

	dodoc mpdconf.example COMMANDS ChangeLog INSTALL README TODO UPGRADING
}

pkg_postinst() {
	einfo "libao has issues with the ALSA drivers, please refer to the FAQ"
	einfo "http://musicpd.sourceforge.net/faq.php"
}

# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-sound/yammi/yammi-0.7.ebuild,v 1.1 2003/03/15 07:04:16 jje Exp $

S="${WORKDIR}/${P}"

DESCRIPTION="MP3/Ogg/Wav-Manager and Jukebox 4 XMMS/Noatun"
SRC_URI="mirror://sourceforge/yammi/${P}.tar.gz"
HOMEPAGE="http://yammi.sf.net"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=x11-libs/qt-3.1.0-r1
	>=media-sound/xmms-1.2.7-r18
	>=media-libs/id3lib-3.8.2
	>=media-libs/libvorbis-1.0-r1
	>=media-sound/mpg123-0.59r-r1
	>=media-sound/cdparanoia-3.9.8
	>=media-sound/lame-3.93.1
	>=app-cdr/mp3burn-0.1
	>=app-cdr/cdlabelgen-2.4.0"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	
	make || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS CHANGELOG CREDITS INSTALL README TODO
}

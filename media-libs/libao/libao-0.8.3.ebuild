# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/libao/libao-0.8.3.ebuild,v 1.1 2002/07/19 23:22:28 lostlogic Exp $

S=${WORKDIR}/${P}
DESCRIPTION="the audio output library"
SRC_URI="http://fatpipe.vorbis.com/files/1.0/unix/${P}.tar.gz"
HOMEPAGE="http://www.xiph.org/ogg/vorbis/index.html"
SLOT="0"
KEYWORDS="x86 ppc"
LICENSE="as-is"

DEPEND="virtual/glibc
        esd? ( >=media-sound/esound-0.2.22 )"

src_compile() {
	./configure --host=${CHOST} \
			--prefix=/usr \
			--enable-shared \
			--enable-static || die

	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
    
	rm -rf ${D}/usr/share/doc
	dodoc AUTHORS CHANGES COPYING README TODO
	dodoc doc/API doc/DRIVERS doc/USAGE doc/WANTED
}

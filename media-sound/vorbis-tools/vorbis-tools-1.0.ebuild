# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-sound/vorbis-tools/vorbis-tools-1.0.ebuild,v 1.1 2002/07/19 23:27:45 lostlogic Exp $

S=${WORKDIR}/${P}
DESCRIPTION="tools for using the Ogg Vorbis sound file format"
SRC_URI="http://fatpipe.vorbis.com/files/1.0/unix/vorbis-tools-1.0.tar.gz"
HOMEPAGE="http://www.xiph.org/ogg/vorbis/index.html"
DEPEND=">=media-libs/libvorbis-${PV}
        >=media-libs/libao-0.8.2
	>=net-ftp/curl-7.9"
SLOT="0"
KEYWORDS="x86 ppc"
LICENSE="as-is"

src_compile() {
	./configure --prefix=/usr --host=${CHOST} || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	rm -rf ${D}/usr/share/doc
	dodoc AUTHORS COPYING README
	docinto ogg123
	dodoc ogg123/ogg123rc-example
}


# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author James M Long <semaj@semaj.org>


S=${WORKDIR}/${P}
DESCRIPTION="s.q.u.e.l.c.h is an Ogg Vorbis audio player."
SRC_URI="http://www.geoid.clara.net/rik/arch/${P}.tar.gz"
HOMEPAGE="http://www.geoid.clara.net/rik/squelch.html"

DEPEND="virtual/x11 virtual/glibc
	>=media-libs/libvorbis-1.0_rc1
	>=media-libs/libao-0.8.0
	>=x11-libs/qt-2.3.1
	>=media-libs/libogg-1.0_rc1"

# The runtime depends are a bit different than the compiling ones
# I created the runtime list from the output of ldd
RDEPEND="{$DEPEND}
	>=media-libs/libpng-1.0.12
	>=sys-libs/zlib-1.1.3
	>=media-libs/jpeg-6b
	>=media-libs/libmng-1.0.1
	nas? ( >=media-libs/nas-1.4.1 )
	>=media-libs/lcms-1.06"

src_compile() {
# this package does not have any info files
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--mandir=/usr/share/man || die
	emake || die	
}	

src_install() {                               
	make DESTDIR=${D}
		install || die
# I seem to be having an issue with this part
# It doesn't install the files listed below.	
	dodoc 	AUTHORS COPYING Changelog INSTALL NEWS README THANKS
	
}

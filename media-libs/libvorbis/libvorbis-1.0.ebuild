# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/libvorbis/libvorbis-1.0.ebuild,v 1.1 2002/07/19 23:26:47 lostlogic Exp $

inherit libtool

S=${WORKDIR}/${P}
DESCRIPTION="the Ogg Vorbis sound file format library"
SRC_URI="http://fatpipe.vorbis.com/files/1.0/unix/${P}.tar.gz"
HOMEPAGE="http://www.xiph.org/ogg/vorbis/index.html"

DEPEND=">=media-libs/libogg-1.0"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc"

src_unpack() {
	unpack ${A}

	cd ${S}
	# Fix a gcc crash.  With the new atexit patch to gcc, it
	# seems it do not handle -mno-ieee-fp too well.
	cp configure configure.orig
	sed -e "s:-mno-ieee-fp::g" \
		configure.orig >configure
}

src_compile() {
	elibtoolize

	export CFLAGS="${CFLAGS/-march=*/}"

	./configure --prefix=/usr \
		--host=${CHOST} || die

	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	echo "Removing docs installed by make install"
	rm -rf ${D}/usr/share/doc

	dodoc AUTHORS COPYING README todo.txt
	docinto txt
	dodoc doc/*.txt
	dohtml -r doc
}

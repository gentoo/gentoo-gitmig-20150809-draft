# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/libvorbis/libvorbis-1.0_rc3-r2.ebuild,v 1.4 2002/08/14 13:08:10 murphy Exp $

inherit libtool

MY_P=${P/_/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="the Ogg Vorbis sound file format library"
SRC_URI="http://www.vorbis.com/files/rc3/unix/${MY_P}.tar.gz"
HOMEPAGE="http://www.xiph.org/ogg/vorbis/index.html"

DEPEND=">=media-libs/libogg-1.0_rc2"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc sparc sparc64"

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

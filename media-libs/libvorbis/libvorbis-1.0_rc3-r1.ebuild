# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/libvorbis/libvorbis-1.0_rc3-r1.ebuild,v 1.4 2002/07/16 11:36:48 seemant Exp $


S=${WORKDIR}/${PN}-1.0rc3
DESCRIPTION="the Ogg Vorbis sound file format library"
SRC_URI="http://www.vorbis.com/files/rc3/unix/${PN}-1.0rc3.tar.gz"
HOMEPAGE="http://www.xiph.org/ogg/vorbis/index.html"

DEPEND=">=media-libs/libogg-1.0_rc2"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc"

src_compile() {
	export CFLAGS="${CFLAGS/-march=*/}"

	./configure --prefix=/usr --host=${CHOST} || die

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

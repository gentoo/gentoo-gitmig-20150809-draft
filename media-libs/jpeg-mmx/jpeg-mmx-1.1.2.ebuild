# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ryan Tolboom <ryan@gentoo.org>
# /space/gentoo/cvsroot/gentoo-x86/media-libs/jpeg-mmx/jpeg-mmx-1.1.2.ebuild,v 1.1 2001/02/13 14:29:40 ryan Exp

A=${P}.tar.gz
S=${WORKDIR}/jpeg-mmx
DESCRIPTION="JPEG library with mmx enhancements"
SRC_URI="http://download.sourceforge.net/mjpeg/${A}"
HOMEPAGE="http://mjpeg.sourceforge.net/"

DEPEND="virtual/glibc"
RDEPEND="virtual/glibc"

src_compile() {

	try ./configure --enable-shared --prefix=${D}/usr
	try make

}

src_install() {

	dodir /usr/{include/jpeg-mmx,lib}
	make includedir=${D}/usr/include/jpeg-mmx install
	mv ${D}/usr/lib/libjpeg.la ${D}/usr/lib/libjpeg-mmx.la
	mv ${D}/usr/lib/libjpeg.so.62.0.0 ${D}/usr/lib/libjpeg-mmx.so.62.0.0 
	rm ${D}/usr/lib/libjpeg.so
	ln -s /usr/lib/libjpeg-mmx.so.62.0.0 ${D}/usr/lib/libjpeg-mmx.so
	rm ${D}/usr/lib/libjpeg.so.62
	ln -s /usr/lib/libjpeg-mmx.so.62.0.0 ${D}/usr/lib/libjpeg-mmx.so.62
	dodoc README change.log structure.doc libjpeg.doc

}

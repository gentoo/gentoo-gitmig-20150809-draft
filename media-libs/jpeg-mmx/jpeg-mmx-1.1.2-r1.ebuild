# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/jpeg-mmx/jpeg-mmx-1.1.2-r1.ebuild,v 1.1 2002/07/08 03:39:49 spider Exp $

inherit libtool

#- Author Ryan Tolboom <ryan@gentoo.org>
S=${WORKDIR}/jpeg-mmx
DESCRIPTION="JPEG library with mmx enhancements"
SRC_URI="http://download.sourceforge.net/mjpeg/${A}"
HOMEPAGE="http://mjpeg.sourceforge.net/"
SLOT=""
LICENSE="as-is"

DEPEND="virtual/glibc"
RDEPEND="virtual/glibc"

src_compile() {
	elibtoolize
	./configure --enable-shared --prefix=/usr || die "configure failed"
	emake || die "make failed"

}

src_install() {

	dodir /usr/{include/jpeg-mmx,lib}
	make includedir=${D}/usr/include/jpeg-mmx prefix=${D}/usr install || die "install failed"
	mv ${D}/usr/lib/libjpeg.la ${D}/usr/lib/libjpeg-mmx.la
	mv ${D}/usr/lib/libjpeg.so.62.0.0 ${D}/usr/lib/libjpeg-mmx.so.62.0.0 
	rm ${D}/usr/lib/libjpeg.so
	ln -s /usr/lib/libjpeg-mmx.so.62.0.0 ${D}/usr/lib/libjpeg-mmx.so
	rm ${D}/usr/lib/libjpeg.so.62
	ln -s /usr/lib/libjpeg-mmx.so.62.0.0 ${D}/usr/lib/libjpeg-mmx.so.62
	dodoc README change.log structure.doc libjpeg.doc

}

# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/jpeg-mmx/jpeg-mmx-1.1.2-r1.ebuild,v 1.7 2003/02/13 12:46:16 vapier Exp $

inherit libtool

S=${WORKDIR}/jpeg-mmx
DESCRIPTION="JPEG library with mmx enhancements"
SRC_URI="mirror://sourceforge/mjpeg/${P}.tar.gz"
HOMEPAGE="http://mjpeg.sourceforge.net/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 -ppc -sparc "

DEPEND="virtual/glibc"

src_compile() {
	elibtoolize
	econf --enable-shared || die "configure failed"
	emake || die "make failed"

}

src_install() {

	dodir /usr/{include/jpeg-mmx,lib}
	make \
		includedir=${D}/usr/include/jpeg-mmx \
		prefix=${D}/usr \
		install || die "install failed"

	mv ${D}/usr/lib/libjpeg.la ${D}/usr/lib/libjpeg-mmx.la
	mv ${D}/usr/lib/libjpeg.so.62.0.0 ${D}/usr/lib/libjpeg-mmx.so.62.0.0 
	rm ${D}/usr/lib/libjpeg.so
	ln -s /usr/lib/libjpeg-mmx.so.62.0.0 ${D}/usr/lib/libjpeg-mmx.so
	rm ${D}/usr/lib/libjpeg.so.62
	ln -s /usr/lib/libjpeg-mmx.so.62.0.0 ${D}/usr/lib/libjpeg-mmx.so.62
	dodoc README change.log structure.doc libjpeg.doc

}

# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/jpeg-mmx/jpeg-mmx-1.1.2-r1.ebuild,v 1.13 2004/03/19 07:56:04 mr_bones_ Exp $

inherit libtool flag-o-matic gnuconfig

S=${WORKDIR}/jpeg-mmx
DESCRIPTION="JPEG library with mmx enhancements"
SRC_URI="mirror://sourceforge/mjpeg/${P}.tar.gz"
HOMEPAGE="http://mjpeg.sourceforge.net/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 -ppc -sparc -amd64"
IUSE=""
DEPEND="virtual/glibc"

src_unpack() {
	unpack ${P}.tar.gz
	epatch ${FILESDIR}/jpeg-mmx-gcc33fix.gz
}

src_compile() {
	# Doesn't work with -fomit-frame-pointer, at least not on k6-2.
	# Someone mentioned that this may be a k6 issue only; I have
	# just a k6-2 to test it on, so I'll just adjust it for the
	# machine I can test.
	is-flag "-march=k6-3" && strip-flags "-fomit-frame-pointer"
	is-flag "-march=k6-2" && strip-flags "-fomit-frame-pointer"
	is-flag "-march=k6" && strip-flags "-fomit-frame-pointer"

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

# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bruce A. Locke
# /space/gentoo/cvsroot/gentoo-x86/media-libs/a52dec/a52dec-0.7.3.ebuild,v 1.1 2002/04/15 12:14:06 seemant Exp

S=${WORKDIR}/${P}
DESCRIPTION="a52dec is a bundle of the liba52 (a free library for decoding ATSC A/52 streams used in DVD, etc) with a test program"
SRC_URI="http://liba52.sourceforge.net/files/${P}.tar.gz"
HOMEPAGE="http://liba52.sourceforge.net"

DEPEND="virtual/glibc >=sys-devel/autoconf-2.52d-r1"

src_compile() {

	local myconf

	use oss \
		|| myconf="${myconf} --disable-oss"

	use static \
		&& myconf="${myconf} --disable-shared --enable-static" \
		|| myconf="${myconf} --enable-shared --disable-static"

	./configure \
		--prefix=/usr \
		--enable-double \
		${myconf} || die

	make || die	

}

src_install() {
	
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		docdir=${D}/usr/share/doc/${PF}/html \
		sysconfdir=${D}/etc \
		install || die

	dodoc AUTHORS COPYING ChangeLog HISTORY INSTALL NEWS README TODO
	dodoc doc/liba52.txt
}

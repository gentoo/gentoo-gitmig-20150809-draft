# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/a52dec/a52dec-0.7.4.ebuild,v 1.3 2002/08/18 06:42:48 gerk Exp $

S=${WORKDIR}/${P}
DESCRIPTION="a52dec is a bundle of the liba52 (a free library for decoding ATSC A/52 streams used in DVD, etc) with a test program"
SRC_URI="http://liba52.sourceforge.net/files/${P}.tar.gz"
HOMEPAGE="http://liba52.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc sparc64"

DEPEND=">=sys-devel/autoconf-2.52d-r1"

src_compile() {

	local myconf

	use oss \
		|| myconf="${myconf} --disable-oss"

	use static \
		&& myconf="${myconf} --disable-shared --enable-static" \
		|| myconf="${myconf} --enable-shared --disable-static"

	econf ${myconf} || die
	make || die	

}

src_install() {
	
	einstall docdir=${D}/usr/share/doc/${PF}/html || die

	dodoc AUTHORS COPYING ChangeLog HISTORY INSTALL NEWS README TODO
	dodoc doc/liba52.txt
}

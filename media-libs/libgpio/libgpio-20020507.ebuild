# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# George Shapovalov <george@gentoo.org>
# /space/gentoo/cvsroot/gentoo-x86/media-libs/libgpio/libgpio-20010607.ebuild,v 1.1 2001/07/03 10:41:22 achim Exp

S=${WORKDIR}/${PN}
DESCRIPTION="libgpio"
SRC_URI="http://www.ibiblio.org/gentoo/${P}.tar.bz2"
HOMEPAGE="http://www.gphoto.org"

DEPEND="dev-libs/libusb sys-devel/automake sys-devel/autoconf sys-devel/libtool"
RDEPEND="dev-libs/libusb"


src_compile() {

	./autogen.sh --prefix=/usr --host=${CHOST} || die
	make || die

}

src_install () {

	make DESTDIR=${D} install || die

}


# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libgpio/libgpio-20020507.ebuild,v 1.9 2003/08/20 04:33:05 vapier Exp $

DESCRIPTION="I/O library for GPhoto 2.x"
HOMEPAGE="http://www.gphoto.org/"
SRC_URI="http://www.ibiblio.org/gentoo/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc"

DEPEND="dev-libs/libusb 
	sys-devel/automake 
	sys-devel/autoconf 
	sys-devel/libtool"
RDEPEND="dev-libs/libusb"

S=${WORKDIR}/${PN}

src_compile() {
	./autogen.sh --prefix=/usr --host=${CHOST} || die
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
}

# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-gfx/zgv/zgv-5.6.ebuild,v 1.3 2002/07/23 05:18:07 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A svgalib console image viewer."
SRC_URI="http://www.svgalib.org/rus/zgv/${P}.tar.gz"
HOMEPAGE="http://www.svgalib.org/rus/zgv"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=media-libs/svgalib-1.4.2
	>=media-libs/jpeg-6b-r2
	media-libs/libpng
	>=media-libs/tiff-3.5.5
	>=sys-libs/zlib-1.1.4"

src_unpack() {

	unpack ${A}
	
	cd ${S}/src
	cp Makefile Makefile.orig
	sed -e "s:-O2 -fomit-frame-pointer -finline-functions:${CFLAGS}:" \
		Makefile.orig > Makefile
}

src_compile() {

	emake || die
}

src_install() {

	dodir /usr/bin /usr/share/info /usr/share/man/man1
	make PREFIX=${D}/usr \
		INFODIR=${D}/usr/share/info \
		MANDIR=${D}/usr/share/man/man1 \
		install || die
	
	# Fix info files
	cd ${D}/usr/share/info
	rm dir*
	mv zgv zgv.info
	for i in 1 2 3 4
	do
		mv zgv-$i zgv.info-$i
	done
	cd ${S}
	
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README* SECURITY TODO
}


# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ben Lutgens <lamer@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/xv/xv-3.10a-r2.ebuild,v 1.1 2002/04/30 05:47:34 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="An interactive image manipulation program for X which can
deal with a wide variety of image formats"
SRC_URI="ftp://ftp.cis.upenn.edu/pub/xv/${P}.tar.gz
	png? http://www.ibiblio.org/gentoo/distfiles/xv-png-patch.tar.bz2"
HOMEPAGE="http://www.trilon.com/xv/index.html"

DEPEND="virtual/x11
	png? ( media-libs/jpeg
		media-libs/tiff
		media-libs/libpng
		>=sys-libs/zlib-1.1.4 )"

PATCHDIR=${WORKDIR}/patches

src_unpack() {
	unpack ${A}
	
	use png && ( \
		cd ${S}
		patch -p1 < ${WORKDIR}/${P}-naz-gentoo.patch || die
	)
}

src_compile() {
	
	make || die
}

src_install () {
	
	dodir /usr/bin
	dodir /usr/share/man/man1
	
	make \
		DESTDIR=${D} \
		BINDIR=${D}/usr/bin \
		MANDIR=${D}/usr/share/man/man1 \
		LIBDIR=${D}/usr/lib \
		install || die

	 dodoc README INSTALL CHANGELOG BUGS IDEAS
}

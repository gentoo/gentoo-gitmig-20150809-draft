# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/xv/xv-3.10a-r4.ebuild,v 1.1 2003/07/31 21:22:52 rphillips Exp $

IUSE="jpeg tiff png zlib X"

DESCRIPTION="An interactive image manipulation program for X which can deal with a wide variety of image formats"
SRC_URI="ftp://ftp.cis.upenn.edu/pub/xv/${P}.tar.gz"
HOMEPAGE="http://www.trilon.com/xv/index.html"

KEYWORDS="~x86 ~ppc ~sparc ~alpha"
SLOT="0"
LICENSE="shareware; only free for personal use."

DEPEND="virtual/x11
	jpeg? ( >=media-libs/jpeg-6b )
	tiff? ( >=media-libs/tiff-3.5 )
	png? ( >=media-libs/libpng-1.2 )
	>=sys-libs/zlib-1.1.4"
RESTRICT="fetch"

src_unpack() {
	unpack ${A}
	
	cd ${S}
	epatch ${FILESDIR}/${P}-enhanced-Nu.patch || die
	epatch ${FILESDIR}/${P}-gentoo-Nu.patch || die
	
	if [ `use ppc` ] 
	then
		cd ${S}
		patch -p1 < ${FILESDIR}/${P}-ppc.patch || die
	fi
}

src_compile() {
	mv Makefile Makefile.orig
	sed -e "s:CCOPTS = -O:CCOPTS = ${CFLAGS}:" \
		Makefile.orig > Makefile
	cd tiff
	mv Makefile Makefile.orig
	sed -e "s:COPTS=\t-O:COPTS= ${CFLAGS}:" \
		Makefile.orig > Makefile
	cd ..
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

	 dodoc README INSTALL CHANGELOG BUGS IDEAS docs/*.ps docs/*.doc
}

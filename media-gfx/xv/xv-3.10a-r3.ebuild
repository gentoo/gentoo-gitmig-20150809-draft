# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/xv/xv-3.10a-r3.ebuild,v 1.5 2003/05/27 01:00:03 taviso Exp $

inherit ccc

IUSE="png"

S=${WORKDIR}/${P}
DESCRIPTION="An interactive image manipulation program for X which can deal with a wide variety of image formats"
SRC_URI="ftp://ftp.cis.upenn.edu/pub/xv/${P}.tar.gz
	png? http://www.ibiblio.org/gentoo/distfiles/xv-png-patch.tar.bz2"
HOMEPAGE="http://www.trilon.com/xv/index.html"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"

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
	
	if [ `use ppc` ] && [ -z `use png` ]
	then
		cd ${S}
		patch -p1 < ${FILESDIR}/xv-${PV}-ppc.patch || die
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
	is-ccc && replace-cc-hardcode 
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

# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/xv/xv-3.10a-r3.ebuild,v 1.12 2004/02/02 19:46:01 mr_bones_ Exp $

inherit ccc eutils

DESCRIPTION="An interactive image manipulation program for X which can deal with a wide variety of image formats"
HOMEPAGE="http://www.trilon.com/xv/index.html"
SRC_URI="ftp://ftp.cis.upenn.edu/pub/xv/${P}.tar.gz
	png? http://www.ibiblio.org/gentoo/distfiles/xv-png-patch.tar.bz2"

LICENSE="xv"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha ~amd64"
IUSE="png"

DEPEND="virtual/x11
	png? ( media-libs/jpeg
		media-libs/tiff
		media-libs/libpng
		>=sys-libs/zlib-1.1.4 )"

src_unpack() {
	unpack ${A}

	cd ${S}
	[ `use png` ] && epatch ${WORKDIR}/${P}-naz-gentoo.patch
	[ `use ppc` ] && [ -z `use png` ] && epatch ${FILESDIR}/xv-${PV}-ppc.patch
}

src_compile() {
	sed -i "s:CCOPTS = -O:CCOPTS = ${CFLAGS}:" Makefile
	sed -i "s:COPTS=\t-O:COPTS= ${CFLAGS}:" tiff/Makefile
	is-ccc && replace-cc-hardcode
	make || die
}

src_install() {
	dodir /usr/bin
	dodir /usr/share/man/man1

	# LIBDIR is where xv installs xvdocs.ps and we dodoc it below
	make \
		DESTDIR=${D} \
		BINDIR=${D}/usr/bin \
		MANDIR=${D}/usr/share/man/man1 \
		LIBDIR=/dev/null \
		install || die

	dodoc README INSTALL CHANGELOG BUGS IDEAS docs/*.ps docs/*.doc
}

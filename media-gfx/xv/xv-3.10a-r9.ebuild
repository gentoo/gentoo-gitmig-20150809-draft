# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/xv/xv-3.10a-r9.ebuild,v 1.2 2005/01/20 16:50:13 j4rg0n Exp $

inherit ccc flag-o-matic eutils

DESCRIPTION="An interactive image manipulation program for X which can deal with a wide variety of image formats"
HOMEPAGE="http://www.trilon.com/xv/index.html"
SRC_URI="ftp://ftp.cis.upenn.edu/pub/xv/${P}.tar.gz
	mirror://gentoo/${P}-gentoo.tar.gz"

LICENSE="xv"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~mips ~hppa ~ia64 ~amd64 ~ppc64 ~ppc-macos"
IUSE="jpeg tiff png"

DEPEND="virtual/x11
	jpeg? ( >=media-libs/jpeg-6b )
	tiff? ( >=media-libs/tiff-3.6.1-r2 )
	png? ( >=media-libs/libpng-1.2 >=sys-libs/zlib-1.1.4 )"

src_unpack() {
	unpack ${A}

	cd ${S}

	use ppc && epatch ${FILESDIR}/${P}-ppc.patch

	epatch ../${P}-enhanced-Nu.patch || die
	epatch ../${P}-gentoo-Nu.patch || die
	epatch ${FILESDIR}/xv-use-getcwd.patch || die
	# fix security issues #61619
	epatch ${FILESDIR}/${P}-security.diff || die

	# These patches from Dave Coffin
	# http://www.cybercom.net/~dcoffin/dcraw/
	epatch ${FILESDIR}/xv-smoothing-algorithm.diff || die
	epatch ${FILESDIR}/xv-optimize-jpeg.diff || die
	epatch ${FILESDIR}/xv-postscript-double-free.diff || die

	if use ppc-macos; then
		epatch ${FILESDIR}/${P}-xv-osx.patch
		epatch ${FILESDIR}/${P}-vdcomp-osx.patch
		epatch ${FILESDIR}/${P}-makefile-osx.patch
	fi
}

src_compile() {
	if use jpeg; then
		append-flags -DDOJPEG
	else
		sed -i -e "s:JPEGLIB = -ljpeg:JPEGLIB =:" Makefile || die "sed jpeg failed"
	fi
	if use png; then
		append-flags -DDOPNG
	else
		sed -i -e "s:PNGLIB = -lpng:PNGLIB =:" Makefile || die "sed png failed"
		sed -i -e "s:ZLIBLIB = -lz:ZLIBLIB =:" Makefile || die "sed zlib failed"
	fi
	if use tiff; then
		append-flags -DDOTIFF
	else
		sed -i -e "s:TIFFLIB = -ltiff:TIFFLIB =:" Makefile || die "sed tiff failed"
	fi
	sed -i 's:CCOPTS = -O:CCOPTS = $(E_CFLAGS):' Makefile || die "sed Makefile failed"
	sed -i 's:COPTS=\t-O:COPTS= $(E_CFLAGS):' tiff/Makefile || die "sed tiff/Makefile failed"
	is-ccc && replace-cc-hardcode
	echo make E_CFLAGS="${CFLAGS}" > go.sh
	make E_CFLAGS="${CFLAGS}" || die
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

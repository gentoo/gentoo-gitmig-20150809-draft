# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/imagemagick/imagemagick-5.2.7.ebuild,v 1.1 2001/01/22 04:58:31 achim Exp $

P=ImageMagick-${PV}
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A collection of tools and libraries for many image formats"
SRC_URI="ftp://ftp.fifi.org/pub/ImageMagick/${A}"
HOMEPAGE="http://www.imagemagick.org"

DEPEND=">=app-text/dgs-0.5.9.1
	>=sys-devel/perl-5
	>=media-libs/freetype-1.3.1
	>=media-libs/jpeg-6b
	>=media-libs/tiff-3.5.5
	>=media-libs/libpng-1.0.7
	>=x11-base/xfree-4.0.1
	app-text/ghostscript
	app-text/tetex
	media-gfx/gimp
	media-video/mpeg2vidcodec
	net-misc/wget
	|| ( net-print/LPRng net-print/cups )
	|| ( net-www/navigator net-www/netscape )"

RDEPEND=">app-text/dgs-0.5.9.1
	>=media-libs/jpeg-6b
	>=media-libs/freetype-1.3.1
	>=media-libs/libpng-1.0.7"

src_compile() {

    cd ${S}
    try ./configure CFLAGS=\"$CFLAGS -I/opt/gnome/include\" \
		--prefix=/usr/X11R6 --build=${CHOST} \
		--without-xml --enable-lzw --without-ttf \
		--enable-shared --with-threads 
    try make

}

src_install () {

    cd ${S}
    try make prefix=${D}/usr/X11R6 PREFIX=${D}/usr install

}


# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/imagemagick/imagemagick-5.3.3.ebuild,v 1.2 2001/05/18 17:13:55 achim Exp $

P=ImageMagick-${PV}
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A collection of tools and libraries for many image formats"
SRC_URI="ftp://ftp.fifi.org/pub/ImageMagick/${A}"
HOMEPAGE="http://www.imagemagick.org"

DEPEND=">=app-text/dgs-0.5.9.1
	>=sys-devel/perl-5
	=media-libs/freetype-1.3.1-r2
	>=media-libs/jpeg-6b
	>=media-libs/tiff-3.5.5
	>=media-libs/libpng-1.0.7
	virtual/x11
	virtual/lpr"

RDEPEND=">app-text/dgs-0.5.9.1
	>=media-libs/jpeg-6b
	>=media-libs/freetype-1.3.1
	>=media-libs/libpng-1.0.7"

src_compile() {

    try ./configure CFLAGS=\"$CFLAGS -I/opt/gnome/include\" \
		--prefix=/usr/X11R6 --build=${CHOST} \
		--without-xml --enable-lzw --without-ttf \
		--enable-shared --with-threads --mandir=/usr/X11R6/share/man
    try make

}

src_install () {

    try make prefix=${D}/usr/X11R6 PREFIX=${D}/usr \
	INSTALLMAN3DIR=${D}/usr/share/man/man3 \
	INSTALLMAN1DIR=${D}/usr/share/man/man1 \
	mandir=${D}/usr/X11R6/share/man install

}


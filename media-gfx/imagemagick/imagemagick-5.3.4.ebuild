# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/imagemagick/imagemagick-5.3.4.ebuild,v 1.3 2001/06/11 08:11:28 hallski Exp $

P=ImageMagick-${PV}
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A collection of tools and libraries for many image formats"
SRC_URI="ftp://ftp.fifi.org/pub/ImageMagick/${A}"
HOMEPAGE="http://www.imagemagick.org"

DEPEND="virtual/glibc sys-devel/gcc >=app-text/dgs-0.5.9.1
	perl? ( >=sys-devel/perl-5 )
        >=sys-apps/bzip2-1
	>=media-libs/freetype-2.0
	>=media-libs/tiff-3.5.5
	>=media-libs/libpng-1.0.7
	virtual/x11
	virtual/lpr"

RDEPEND="virtual/glibc sys-devel/gcc >app-text/dgs-0.5.9.1
        >=sys-apps/bzip2-1
	>=media-libs/tiff-3.5.5
	>=media-libs/freetype-2.0
	>=media-libs/libpng-1.0.7"

src_compile() {
    local myconf
    if [ -z "`use perl`" ] ; then
      myconf="--without-perl"
    fi
    try ./configure \
		--prefix=/usr/X11R6 --build=${CHOST} --enable-shared --enable-static \
		--without-xml --without-lcms --enable-lzw --with-ttf --without-fpx \
                --without-gslib --without-hdf --without-jbig --without-wmf
		--enable-shared --with-threads --mandir=/usr/X11R6/man $myconf
    try pmake

}

src_install () {

    try make prefix=${D}/usr/X11R6 PREFIX=${D}/usr \
	INSTALLMAN3DIR=${D}/usr/share/man/man3 \
	INSTALLMAN1DIR=${D}/usr/share/man/man1 \
	mandir=${D}/usr/X11R6/man install

}


# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/imagemagick/imagemagick-5.4.0.ebuild,v 1.1 2001/11/21 02:36:31 woodchip Exp $

P=ImageMagick-${PV}
S=${WORKDIR}/${P}
DESCRIPTION="A collection of tools and libraries for many image formats"
SRC_URI="ftp://ftp.fifi.org/pub/ImageMagick/${P}.tar.gz"
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
	use perl || myconf="--without-perl"

	./configure \
	--prefix=/usr --enable-shared --enable-static --without-xml --without-lcms \
	--enable-lzw --with-ttf --without-fpx --without-gslib --without-hdf \
	--without-jbig --without-wmf --with-threads --mandir=/usr/share/man \
	--build=${CHOST} ${myconf} || die "bad configure"

	emake || die "compile problem"
}

src_install () {

	make \
	prefix=${D}/usr \
	PREFIX=${D}/usr \
	mandir=${D}/usr/share/man \
	install || die "install problem"

	dodoc Copyright.txt PLATFORMS.txt QuickStart.txt README.txt TODO.txt
}

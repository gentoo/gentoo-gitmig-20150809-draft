# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/imagemagick/imagemagick-5.4.4-r2.ebuild,v 1.3 2002/04/17 17:41:03 azarah Exp $

MY_PN=ImageMagick
MY_P=${MY_PN}-${PV}-4
S=${WORKDIR}/${MY_PN}-${PV}
DESCRIPTION="A collection of tools and libraries for many image formats"
SRC_URI="http://imagemagick.sourceforge.net/http/${MY_P}.tar.gz"
HOMEPAGE="http://www.imagemagick.org/"


DEPEND="X? ( virtual/x11 )
	>=app-text/dgs-0.5.9.1
	>=sys-apps/bzip2-1
	>=sys-libs/zlib-1.1.3
	>=media-libs/freetype-2.0
	>=media-libs/jpeg-6b
	>=media-libs/tiff-3.5.5
	media-libs/libpng
	gs?   ( >=app-text/ghostscript-6.50 )
	lcms? ( >=media-libs/lcms-1.06 )
	perl? ( >=sys-devel/perl-5 )
	xml2? ( >=dev-libs/libxml2-2.4.10 )"


src_compile() {
	libtoolize --copy --force

	local myconf=""
	use perl || myconf="--without-perl"
	use lcms || myconf="${myconf} --without-lcms"
	use xml2 || myconf="${myconf} --without-xml"
	use X    || myconf="${myconf} --with-x=no"

	# Netscape is still used ?  More people should have Mozilla
	cp configure configure.orig
	sed -e 's:netscape:mozilla:g' configure.orig > configure

	./configure --prefix=/usr \
		--mandir=/usr/share/man \
		--enable-shared \
		--enable-static \
		--enable-lzw \
		--with-ttf \
		--without-fpx \
		--without-gslib \
		--without-hdf \
		--without-jbig \
		--without-wmf \
		--with-threads \
		--build=${CHOST} \
		${myconf} || die "bad configure"

	emake || die "compile problem"
}

src_install() {

	make prefix=${D}/usr \
		PREFIX=${D}/usr \
		INSTALLPRIVLIB=${D}/usr/lib/perl5 \
		INSTALLSCRIPT=${D}/usr/bin \
		INSTALLSITELIB=${D}/usr/lib/perl5/site_perl \
		INSTALLBIN=${D}/usr/bin \
		INSTALLMAN1DIR=${D}/usr/share/man/man1  \
		INSTALLMAN3DIR=${D}/usr/share/man/man3 \
		mandir=${D}/usr/share/man \
		MagickSharePath=${D}/usr/share/ImageMagick/ \
		pkgdocdir=${D}/usr/share/doc/${PF}/html \
		install || die "install problem"

	rm -f ${D}/usr/share/ImageMagick/*.txt

	dodoc Copyright.txt PLATFORMS.txt QuickStart.txt README.txt TODO.txt
}

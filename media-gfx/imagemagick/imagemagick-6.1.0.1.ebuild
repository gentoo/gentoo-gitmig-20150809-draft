# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/imagemagick/imagemagick-6.1.0.1.ebuild,v 1.5 2004/10/20 01:57:13 weeve Exp $

inherit libtool flag-o-matic eutils

MY_PN=ImageMagick
MY_P=${MY_PN}-${PV%.*}
MY_P2=${MY_PN}-${PV%.*}-${PV#*.*.*.}

S=${WORKDIR}/${MY_P}
DESCRIPTION="A collection of tools and libraries for many image formats"
HOMEPAGE="http://www.imagemagick.org/"
SRC_URI="ftp://ftp.imagemagick.org/pub/${MY_PN}/${MY_P2}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ppc sparc alpha hppa ~amd64 ~mips ~ppc64 ia64"
IUSE="X cups jpeg lcms mpeg png truetype tiff xml2 wmf jbig perl graphviz"

DEPEND=">=sys-apps/sed-4
	app-arch/bzip2
	sys-libs/zlib
	X? ( virtual/x11
		>=app-text/dgs-0.5.9.1 )
	cups?   ( virtual/ghostscript )
	lcms? ( >=media-libs/lcms-1.06 )
	mpeg? ( media-video/mpeg2vidcodec )
	png? ( media-libs/libpng )
	tiff? ( >=media-libs/tiff-3.5.5 )
	xml2? ( >=dev-libs/libxml2-2.4.10 )
	truetype? ( =media-libs/freetype-2* )
	wmf? ( media-libs/libwmf )
	jbig? ( media-libs/jbigkit )
	jpeg? ( >=media-libs/jpeg-6b )
	perl? ( dev-lang/perl )
	graphviz? ( media-gfx/graphviz )"

src_compile() {

	local myconf=""
	use X    || myconf="${myconf} --with-x=no"
	use cups || myconf="${myconf} --with-gslib"
	use jpeg || myconf="${myconf} --without-jpeg --without-jp2"
	use lcms || myconf="${myconf} --without-lcms"
	use mpeg || myconf="${myconf} --without-mpeg2"
	use tiff || myconf="${myconf} --without-tiff"
	use xml2 || myconf="${myconf} --without-xml"
	use truetype || myconf="${myconf} --without-ttf"
	use wmf || myconf="${myconf} --without-wmf"
	use jbig || myconf="${myconf} --without-jbig"
	use perl || myconf="${myconf} --without-perl"
	use graphviz || myconf="${myconf} --without-dot"

	# Netscape is still used ?  More people should have Mozilla
	sed -i 's:netscape:mozilla:g' configure

	econf \
		--enable-shared \
		--enable-lzw \
		--with-fpx \
		--without-hdf \
		--with-threads \
		--with-bzlib \
		--without-dot \
		--with-modules \
		--with-zlib \
		${myconf} || die

	emake || die "compile problem"
}

src_install() {
	make DESTDIR=${D} install
	mydoc="*.txt www/*"

	rm -f ${D}/usr/share/ImageMagick/*.txt

	dosed "s:-I/usr/include ::" /usr/bin/Magick-config
	dosed "s:-I/usr/include ::" /usr/bin/Magick++-config

}

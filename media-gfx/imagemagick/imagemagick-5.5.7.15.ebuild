# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/imagemagick/imagemagick-5.5.7.15.ebuild,v 1.2 2004/01/02 18:01:45 aliz Exp $

inherit libtool flag-o-matic
replace-flags k6-3 i586
replace-flags k6-2 i586
replace-flags k6 i586

IUSE="X cups jpeg lcms mpeg png truetype tiff xml2 wmf jbig"

MY_PN=ImageMagick

### uncomment the right variables depending on if we have a patchlevel or not
MY_P=${MY_PN}-${PV%.*}-${PV#*.*.*.}
MY_P2=${MY_PN}-${PV%.*}
#MY_P=${MY_PN}-${PV}
#MY_P2=${MY_PN}-${PV}

S=${WORKDIR}/${MY_P2}
DESCRIPTION="A collection of tools and libraries for many image formats"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"
RESTRICT="nomirror"
HOMEPAGE="http://www.imagemagick.org/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64"

DEPEND=">=sys-apps/sed-4
	>=app-arch/bzip2-1
	sys-libs/zlib
	X? ( virtual/x11
		>=app-text/dgs-0.5.9.1 )
	cups?   ( virtual/ghostscript )
	jpeg? ( >=media-libs/jpeg-6b )
	lcms? ( >=media-libs/lcms-1.06 )
	mpeg? ( media-video/mpeg2vidcodec )
	png? ( media-libs/libpng )
	tiff? ( >=media-libs/tiff-3.5.5 )
	xml2? ( >=dev-libs/libxml2-2.4.10 )
	truetype? ( =media-libs/freetype-2* )
	wmf? ( media-libs/libwmf )
	jbig? ( media-libs/jbigkit )"

src_compile() {
	elibtoolize

	local myconf=""
	use X    || myconf="${myconf} --with-x=no"
	use cups || myconf="${myconf} --without-gslib"
	use jpeg || myconf="${myconf} --without-jpeg --without-jp2"
	use lcms || myconf="${myconf} --without-lcms"
	use mpeg || myconf="${myconf} --without-mpeg2"
	use tiff || myconf="${myconf} --without-tiff"
	use xml2 || myconf="${myconf} --without-xml"
	use truetype || myconf="${myconf} --without-ttf"
	use wmf || myconf="${myconf} --without-wmf"
	use jbig || myconf="${myconf} --without-jbig"

	# Netscape is still used ?  More people should have Mozilla
	sed -i 's:netscape:mozilla:g' configure

	#patch to allow building by perl
	epatch ${FILESDIR}/perlpatch.diff

	econf \
		--enable-shared \
		--enable-lzw \
		--with-fpx \
		--with-jbig \
		--without-hdf \
		--with-threads \
		--with-bzlib \
		${myconf} || die
		#--enable-static \

	emake || die "compile problem"
}

src_install() {
	make DESTDIR=${D} install
	mydoc="*.txt"

	rm -f ${D}/usr/share/ImageMagick/*.txt

	dosed "s:-I/usr/include ::" /usr/bin/Magick-config
	dosed "s:-I/usr/include ::" /usr/bin/Magick++-config

	dosym /usr/lib/libMagick.so /usr/lib/libMagick-5.5.7-Q16.so.0.0.0
}

# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/imagemagick/imagemagick-6.1.3.4.ebuild,v 1.6 2004/11/25 20:59:05 sekretarz Exp $

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
# PLEASE BUMP AND UPDATE KEYWORDS OF dev-perl/perlmagick TO MATCH THIS. THANK YOU.
KEYWORDS="~alpha amd64 ~hppa ~ia64 ~mips ppc ppc64 ~sparc x86"
IUSE="X cups jpeg lcms mpeg png truetype tiff xml2 wmf jbig perl graphviz fpx"

DEPEND=">=sys-apps/sed-4
	app-arch/bzip2
	sys-libs/zlib
	X? ( virtual/x11 )
	cups?   ( virtual/ghostscript )
	lcms? ( >=media-libs/lcms-1.06 )
	mpeg? ( >=media-video/mpeg2vidcodec-12 )
	png? ( media-libs/libpng )
	tiff? ( >=media-libs/tiff-3.5.5 )
	xml2? ( >=dev-libs/libxml2-2.4.10 )
	truetype? ( =media-libs/freetype-2* )
	wmf? ( >=media-libs/libwmf-0.2.8 )
	jbig? ( media-libs/jbigkit )
	jpeg? ( >=media-libs/jpeg-6b )
	perl? ( dev-lang/perl )
	graphviz? ( media-gfx/graphviz )
	fpx? ( media-libs/libfpx )"

RDEPEND="${DEPEND}
		>=sys-devel/libtool-1.5.2-r6"

src_unpack() {
	unpack ${A}
	cd ${S}

	chmod +x config.sub
}

src_compile() {
	econf \
		--enable-shared \
		--enable-lzw \
		--without-hdf \
		--with-threads \
		--with-bzlib \
		--with-modules \
		--with-zlib \
		$(use_with X x) \
		$(use_with wmf) \
		$(use_with fpx) \
		$(use_with perl) \
		$(use_with jbig) \
		$(use_with tiff) \
		$(use_with lcms) \
		$(use_with xml2 xml) \
		$(use_with jpeg jp2) \
		$(use_with jpeg jpeg) \
		$(use_with mpeg mpeg2) \
		$(use_with cups gslib) \
		$(use_with graphviz dot) \
		$(use_with truetype ttf) || die "econf failed"

	emake || die "compile problem"
}

src_install() {
	make DESTDIR=${D} install

	#bug 69705
	rm -f ${D}/usr/lib/libltdl*

	dosed "s:-I/usr/include ::" /usr/bin/Magick-config
	dosed "s:-I/usr/include ::" /usr/bin/Magick++-config

}

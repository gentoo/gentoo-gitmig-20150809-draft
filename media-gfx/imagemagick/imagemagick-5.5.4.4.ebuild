# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/imagemagick/imagemagick-5.5.4.4.ebuild,v 1.6 2003/04/28 16:51:46 mholzer Exp $

inherit libtool
inherit perl-module
inherit flag-o-matic
replace-flags k6-3 i586
replace-flags k6-2 i586  
replace-flags k6 i586  

IUSE="X cups jpeg lcms mpeg perl png truetype tiff xml2"

MY_PN=ImageMagick
MY_P=${MY_PN}-${PV%.*}-${PV#*.*.*.}
MY_P2=${MY_PN}-${PV%.*}
S=${WORKDIR}/${MY_P2}
DESCRIPTION="A collection of tools and libraries for many image formats"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
HOMEPAGE="http://www.imagemagick.org/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 ~ppc ~sparc alpha ~mips ~hppa"

DEPEND="media-libs/jbigkit
	>=sys-apps/bzip2-1
	sys-libs/zlib
	>=media-libs/freetype-2.0
	X? ( virtual/x11 
		>=app-text/dgs-0.5.9.1 )
	cups?   ( >=app-text/ghostscript-6.50 )
	jpeg? ( >=media-libs/jpeg-6b )
	lcms? ( >=media-libs/lcms-1.06 )
	mpeg? ( media-video/mpeg2vidcodec )
	perl? ( >=dev-lang/perl-5 )
	png? ( media-libs/libpng )
	tiff? ( >=media-libs/tiff-3.5.5 )
	xml2? ( >=dev-libs/libxml2-2.4.10 )
	truetype? ( =media-libs/freetype-2* )"

src_compile() {
	elibtoolize

	local myconf=""
	use X    || myconf="${myconf} --with-x=no"
	use cups || myconf="${myconf} --without-gslib"
	use jpeg || myconf="${myconf} --without-jpeg --without-jp2"
	use lcms || myconf="${myconf} --without-lcms"
	use mpeg || myconf="${myconf} --without-mpeg2"
	use perl || myconf="${myconf} --without-perl"
	use tiff || myconf="${myconf} --without-tiff"
	use xml2 || myconf="${myconf} --without-xml"
	use truetype || myconf="${myconf} --without-ttf"

	# Netscape is still used ?  More people should have Mozilla
	cp configure configure.orig
	sed -e 's:netscape:mozilla:g' configure.orig > configure

	#patch to allow building by perl
	patch -p0 < ${FILESDIR}/perlpatch.diff

	econf \
		--enable-shared \
		--enable-static \
		--enable-lzw \
		--with-fpx \
		--with-jbig \
		--without-hdf \
		--with-wmf \
		--with-threads \
		--with-bzlib \
		${myconf}
	emake || die "compile problem"

	# More perl stuff 
	cd PerlMagick
	make clean
	perl-module_src_prep
}

src_install() {
#	myinst="prefix=${D}/usr PREFIX=${D}/usr"
#	myinst="${myinst} MagickSharePath=${D}/usr/share/ImageMagick/"
#	myinst="${myinst} pkgdocdir=${D}/usr/share/doc/${PF}/html/"
#	myinst="${myinst} mandir=${D}/usr/share/man"
#	myinst="${myinst} datadir=${D}/usr/share"
#	myinst="${myinst} libdir=${D}/usr/lib"
#	myinst="${myinst} MagickLibPath=${D}/usr/lib/${MY_P2}"
#	myinst="${myinst} MagickModulesPath=${D}/usr/lib/${MY_P2}/modules/coders"
#	myinst="${myinst} MagickSharePath=${D}/usr/share/${MY_PN}"
	myinst="DESTDIR=${D}"

	# sandbox violation hack
#	cp coders/Makefile coders/Makefile.bak
#	sed \
#		-e "s:^pkglibdir = :pkglibdir = ${D}:" \
#		-e "s:^MagickLibPath = :MagickLibPath = ${D}:" \
#		-e "s:^MagickModulesPath = :MagickModulesPath = ${D}:" \
#		-e "s:^MagickSharePath = :MagickSharePath = ${D}:" \
#		coders/Makefile.bak coders/Makefile

	mydoc="*.txt"
	perl-module_src_install
	
	rm -f ${D}/usr/share/ImageMagick/*.txt

	dosed "s:-I/usr/include ::" /usr/bin/Magick-config
	dosed "s:-I/usr/include ::" /usr/bin/Magick++-config
}

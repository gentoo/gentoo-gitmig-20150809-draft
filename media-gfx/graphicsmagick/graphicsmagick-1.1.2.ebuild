# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/graphicsmagick/graphicsmagick-1.1.2.ebuild,v 1.4 2004/11/02 01:39:20 spyderous Exp $

inherit libtool flag-o-matic perl-module
replace-flags k6-3 i586
replace-flags k6-2 i586
replace-flags k6 i586

IUSE="X gs jbig jp2 jpeg lcms lzw perl png tiff truetype wmf xml2"

MY_PN=GraphicsMagick
MY_P=${MY_PN}-${PV}

S=${WORKDIR}/${MY_P}
DESCRIPTION="A collection of tools and libraries for many image formats"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"
HOMEPAGE="http://www.graphicsmagick.org/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86"

DEPEND=">=sys-apps/sed-4
	>=app-arch/bzip2-1
	sys-libs/zlib
	X? ( virtual/x11 )
	gs?   ( >=app-text/ghostscript-7.05 )
	jbig? ( media-libs/jbigkit )
	jp2? ( media-libs/jasper )
	jpeg? ( >=media-libs/jpeg-6b )
	lcms? ( >=media-libs/lcms-1.06 )
	perl? ( dev-lang/perl )
	png? ( media-libs/libpng )
	tiff? ( >=media-libs/tiff-3.5.5 )
	xml2? ( >=dev-libs/libxml2-2.4.10 )
	truetype? ( =media-libs/freetype-2* )
	wmf? ( >=media-libs/libwmf-0.2.5 )"

src_compile() {
	local myconf=""
	use X    || myconf="${myconf} --with-x=no"
	use jbig || myconf="${myconf} --without-jbig"
	use jp2 || myconf="${myconf} --without-jp2"
	use jpeg || myconf="${myconf} --without-jpeg"
	use lcms || myconf="${myconf} --without-lcms"
	use lzw && myconf="${myconf} --enable-lzw"
	use png || myconf="${myconf} --with-png=no"
	use tiff || myconf="${myconf} --without-tiff"
	use truetype || myconf="${myconf} --without-ttf"
	use wmf || myconf="${myconf} --without-wmf"
	use xml2 || myconf="${myconf} --without-xml"

	# Netscape is still used ?  More people should have Mozilla
	sed -i 's:netscape:mozilla:g' configure

	econf \
		--enable-shared \
		--with-quantum-depth=16 \
		--with-threads \
		--with-bzlib \
		--without-perl \
		${myconf} || die

	# make PerlMagick using portage tools instead of Makefile to avoid sandbox issues
	if use perl ; then
		cd PerlMagick
		perl-module_src_prep
		perl-module_src_compile
		cd ..
	fi

	emake || die "compile problem"
}

src_install() {
	make DESTDIR=${D} install || die

	if use perl ; then
		cd PerlMagick
		perl-module_src_install
		cd ..
	fi

	dosym /usr/lib/${MY_P}/ /usr/lib/GraphicsMagick

	mydoc="*.txt"

	rm -f ${D}/usr/share/GraphicsMagick/*.txt

	dosed "s:-I/usr/include ::" /usr/bin/GraphicsMagick-config
	dosed "s:-I/usr/include ::" /usr/bin/GraphicsMagick++-config
}

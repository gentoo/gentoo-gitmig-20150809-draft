# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/perlmagick/perlmagick-6.2.0.4-r1.ebuild,v 1.4 2005/04/01 05:06:15 agriffis Exp $

inherit perl-module eutils flag-o-matic libtool

# Left this the same as ImageMagick for the sake of simplicity
MY_PN=ImageMagick
MY_P=${MY_PN}-${PV%.*}
MY_P2=${MY_PN}-${PV%.*}-${PV#*.*.*.}

S=${WORKDIR}/${MY_P}
DESCRIPTION="A Perl module to harness the powers of ImageMagick"
HOMEPAGE="http://www.imagemagick.org/"
SRC_URI="mirror://sourceforge/imagemagick/${MY_P2}.tar.gz"

# 2004.09.06 rac
# i think this license needs changing, as does imagemagick. the
# website says "an apache-style license".
LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa amd64 ~mips ppc64 ia64"
IUSE="X cups jpeg lcms mpeg png truetype tiff xml2 wmf jbig perl graphviz fpx"

DEPEND="=media-gfx/imagemagick-${PV}*
	>=sys-apps/sed-4
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
	dev-lang/perl
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
		--with-gs-font-dir=/usr/share/fonts/default/ghostscript \
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

	cd PerlMagick
	perl-module_src_prep
	perl-module_src_compile
}

src_install() {
	cd PerlMagick
	perl-module_src_install
}

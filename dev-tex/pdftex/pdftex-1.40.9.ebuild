# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/pdftex/pdftex-1.40.9.ebuild,v 1.19 2009/12/12 12:27:23 aballier Exp $

inherit libtool toolchain-funcs eutils multilib

DESCRIPTION="Standalone (patched to use poppler) version of pdftex"
HOMEPAGE="http://www.pdftex.org/"
SLOT="0"
LICENSE="GPL-2"

SRC_URI="http://sarovar.org/download.php/1240/${P}.tar.bz2"

KEYWORDS="alpha amd64 arm hppa ia64 ~ppc ~ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=virtual/poppler-0.8
	media-libs/libpng
	sys-libs/zlib"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S="${WORKDIR}/${P}/src"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-poppler.patch"
	epatch "${FILESDIR}/${P}-xpdfversion.patch"
	epatch "${FILESDIR}/${P}-poppler-0.11.patch"
	epatch "${FILESDIR}/${P}-getline.patch"
	has_version '>=dev-libs/poppler-0.11.3' && epatch "${FILESDIR}/${P}-poppler-0.11.3.patch"
	elibtoolize
}

src_compile() {
	# Too many regexps use A-Z a-z constructs, what causes problems with locales
	# that don't have the same alphabetical order than ascii. Bug #293199
	# So we set LC_ALL to C in order to avoid problems.
	export LC_ALL=C

	tc-export CC CXX AR RANLIB

	econf \
		--without-cxx-runtime-hack	\
		--without-aleph				\
		--without-bibtex8			\
		--without-cjkutils			\
		--without-detex				\
		--without-dialog			\
		--without-dtl				\
		--without-dvi2tty			\
		--without-dvidvi			\
		--without-dviljk			\
		--without-dvipdfm			\
		--without-dvipdfmx			\
		--without-dvipng			\
		--without-dvipos			\
		--without-dvipsk			\
		--without-etex				\
		--without-gsftopk			\
		--without-lacheck			\
		--without-lcdf-typetools	\
		--without-makeindexk		\
		--without-mkocp-default		\
		--without-mkofm-default		\
		--without-musixflx			\
		--without-omega				\
		--without-pdfopen			\
		--without-ps2eps			\
		--without-ps2pkm			\
		--without-psutils			\
		--without-sam2p				\
		--without-seetexk			\
		--without-t1utils			\
		--without-tetex				\
		--without-tex4htk			\
		--without-texi2html			\
		--without-texinfo			\
		--without-texlive			\
		--without-ttf2pk			\
		--without-tth				\
		--without-xdv2pdf			\
		--without-xdvik				\
		--without-xdvipdfmx			\
		--without-xetex				\
		--disable-largefile			\
		--with-system-zlib			\
		--with-system-pnglib		\
		--disable-multiplatform

	cd "${S}/texk/web2c"
	emake \
		LIBXPDFDEP="" LDLIBXPDF="$(pkg-config --libs poppler)" \
		LIBXPDFSRCDIR="/usr/include/poppler" LIBXPDFDIR="/usr/include/poppler" \
		ZLIBSRCDIR="." \
		pdftex || die "emake pdftex failed"
}

src_install() {
	cd "${S}/texk/web2c"
	emake bindir="${D}/usr/bin" \
		LIBXPDFDEP="" LDLIBXPDF="$(pkg-config --libs poppler)" \
		LIBXPDFSRCDIR="/usr/include/poppler" LIBXPDFDIR="/usr/include/poppler" \
		ZLIBSRCDIR="." \
		install-pdftex || die "install pdftex failed"
	# Rename it
	mv "${D}/usr/bin/pdftex" "${D}/usr/bin/pdftex-${P}" || die "renaming failed"
}

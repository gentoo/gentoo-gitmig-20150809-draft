# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/pdftex/pdftex-1.40.10.ebuild,v 1.1 2009/12/12 12:21:12 aballier Exp $

inherit libtool toolchain-funcs eutils multilib

DESCRIPTION="Standalone (patched to use poppler) version of pdftex"
HOMEPAGE="http://www.pdftex.org/"
SLOT="0"
LICENSE="GPL-2"

SRC_URI="http://sarovar.org/frs/download.php/1292/${P}.tar.bz2"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=virtual/poppler-0.11.3
	media-libs/libpng
	sys-libs/zlib
	app-admin/eselect-pdftex"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S="${WORKDIR}/${P}/src"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-poppler.patch"
	elibtoolize
}

src_compile() {
	#tc-export CC CXX AR RANLIB

	econf \
		--disable-cxx-runtime-hack	\
		--disable-afm2pl			\
		--disable-aleph				\
		--disable-bibtex			\
		--disable-bibtex8			\
		--disable-cfftot1			\
		--disable-cjkutils			\
		--disable-devnag			\
		--disable-detex				\
		--disable-dialog			\
		--disable-dtl				\
		--disable-dvi2tty			\
		--disable-dvidvi			\
		--disable-dviljk			\
		--disable-dvipdfm			\
		--disable-dvipdfmx			\
		--disable-dvipng			\
		--disable-dvipos			\
		--disable-dvipsk			\
		--disable-gsftopk			\
		--disable-lacheck			\
		--disable-lcdf-typetools	\
		--disable-luatex			\
		--disable-makeindexk		\
		--disable-mf				\
		--disable-mmafm				\
		--disable-mmpfb				\
		--disable-mp				\
		--disable-musixflx			\
		--disable-one				\
		--disable-otfinfo			\
		--disable-otftotfm			\
		--disable-pdfopen			\
		--disable-ps2eps			\
		--disable-ps2pkm			\
		--disable-psutils			\
		--disable-seetexk			\
		--disable-t1dotlessj		\
		--disable-t1lint			\
		--disable-t1rawafm			\
		--disable-t1reencode		\
		--disable-t1testpage		\
		--disable-t1utils			\
		--disable-tex				\
		--disable-tex4htk			\
		--disable-tpic2pdftex		\
		--disable-ttf2pk			\
		--disable-ttfdump			\
		--disable-ttftotype42		\
		--disable-vlna				\
		--disable-web-progs			\
		--disable-xetex				\
		--disable-xdv2pdf			\
		--disable-xdvik				\
		--disable-xdvipdfmx			\
		--disable-native-texlive-build \
		--disable-tetex				\
		--disable-texlive			\
		--without-mf-x-toolkit		\
		--without-x					\
		--disable-shared			\
		--disable-largefile			\
		--with-system-xpdf			\
		--with-system-zlib			\
		--with-system-pnglib		\
		--disable-multiplatform

	emake SHELL=/bin/sh || die
}

src_install() {
	cd "${S}/texk/web2c"
	emake DESTDIR="${D}" \
		SUBDIRS="" \
		bin_PROGRAMS="pdftex" \
		nodist_man_MANS="" \
		dist_man_MANS="" \
		install || die
	# Rename it
	mv "${D}/usr/bin/pdftex" "${D}/usr/bin/pdftex-${P}" || die "renaming failed"
}

pkg_postinst(){
	einfo "Calling eselect pdftex update"
	eselect pdftex update
}

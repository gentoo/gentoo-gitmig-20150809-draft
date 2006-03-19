# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/poppler/poppler-0.5.0-r5.ebuild,v 1.12 2006/03/19 02:05:06 metalgod Exp $

inherit autotools eutils flag-o-matic

DESCRIPTION="Poppler is a PDF rendering library based on the xpdf-3.0 code base."
HOMEPAGE="http://poppler.freedesktop.org"
SRC_URI="http://poppler.freedesktop.org/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86"
IUSE="jpeg cairo"

RDEPEND=">=media-libs/freetype-2.1.8
	media-libs/fontconfig
	cairo? ( >=x11-libs/cairo-0.5 )
	jpeg? ( >=media-libs/jpeg-6b )
	!app-text/pdftohtml
	!<app-text/xpdf-3.01-r4
	virtual/ghostscript"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=sys-devel/automake-1.9.6"

src_unpack(){
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-cairo-ft.patch
	epatch ${FILESDIR}/${PN}-0.4.4-bug117481.patch
	epatch ${FILESDIR}/${PN}-0.4.3-pdf2xml.patch
	epatch ${FILESDIR}/${PN}-0.4.4-cairo-lines.patch
	# bug #119898
	epatch ${FILESDIR}/${P}-try-all-fonts.patch
	epatch ${FILESDIR}/${P}-splash-overflow.patch
	epatch ${FILESDIR}/${P}-pdftoppm.patch
	AT_M4DIR="m4" eautoreconf
}

src_compile() {
	# -Os is broken, see bug 124179
	replace-flags -Os -O2

	econf --disable-poppler-qt4 \
		--disable-poppler-glib \
		--disable-poppler-qt \
		--disable-gtk-test \
		--enable-opi \
		--enable-xpdf-headers \
		$(use_enable cairo cairo-output) \
		$(use_enable jpeg libjpeg) \
		|| die "configuration failed"
		# $(use_enable zlib) breaks, see
		# https://bugs.freedesktop.org/show_bug.cgi?id=3948
	emake || die "compilation failed"
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README AUTHORS ChangeLog NEWS README-XPDF TODO pdf2xml.dtd
}

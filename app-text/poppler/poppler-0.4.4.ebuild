# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/poppler/poppler-0.4.4.ebuild,v 1.1 2006/01/19 19:10:52 dang Exp $

inherit eutils autotools

DESCRIPTION="Poppler is a PDF rendering library based on the xpdf-3.0 code base."
HOMEPAGE="http://poppler.freedesktop.org"
SRC_URI="http://poppler.freedesktop.org/${P}.tar.gz
	mirror://gentoo/${P}-utils.patch.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="jpeg zlib cairo"

RDEPEND=">=media-libs/freetype-2.1.8
	media-libs/fontconfig
	cairo? ( >=x11-libs/cairo-0.5 )
	jpeg? ( >=media-libs/jpeg-6b )
	zlib? ( sys-libs/zlib )
	!app-text/pdftohtml
	!<app-text/xpdf-3.01-r4
	virtual/ghostscript"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=sys-devel/automake-1.9.6"

src_unpack(){
	unpack ${A}
	cd ${S}
	epatch ${WORKDIR}/${P}-utils.patch
	epatch ${FILESDIR}/poppler-0.4.1-cairo-ft.patch
	epatch ${FILESDIR}/${P}-bug117481.patch
	epatch ${FILESDIR}/${PN}-0.4.3-pdf2xml.patch
	epatch ${FILESDIR}/${P}-cairo-lines.patch
	eautoreconf
}

src_compile() {
	econf --disable-poppler-qt4 --enable-opi \
		--disable-poppler-glib --disable-poppler-qt \
		$(use_enable cairo cairo-output) \
		$(use_enable jpeg libjpeg) \
		$(use_enable zlib) \
		|| die "configuration failed"
	emake || die "compilation failed"
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README AUTHORS ChangeLog NEWS README-XPDF TODO pdf2xml.dtd
}

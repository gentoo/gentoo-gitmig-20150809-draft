# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/xpdf/xpdf-2.01-r1.ebuild,v 1.1 2003/01/04 17:09:11 aliz Exp $

S=${WORKDIR}/${P}
DESCRIPTION="An X Viewer for PDF Files"
SRC_URI="ftp://ftp.foolabs.com/pub/xpdf/${P}.tar.gz
	ftp://ftp.foolabs.com/pub/xpdf/${P}-patch1"
HOMEPAGE="http://www.foolabs.com/xpdf/xpdf.html"
IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc"

DEPEND="virtual/x11
	x11-libs/lesstif
	>=media-libs/freetype-2.0.5
	>=media-libs/t1lib-1.3
	app-text/ghostscript"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}/xpdf
	patch -p0 < ${DISTDIR}/${P}-patch1 || die
}

src_compile() {
	./configure --enable-freetype2 \
		--with-freetype2-includes=/usr/include/freetype2 \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--sysconfdir=/etc \
		--with-gzip || die

	cat > ${S}/xpdfrc << EOF
# use the Base-14 Type 1 fonts from ghostscript 
displayFontT1 Times-Roman           /usr/share/ghostscript/fonts/n021003l.pfb
displayFontT1 Times-Italic          /usr/share/ghostscript/fonts/n021023l.pfb
displayFontT1 Times-Bold            /usr/share/ghostscript/fonts/n021004l.pfb
displayFontT1 Times-BoldItalic      /usr/share/ghostscript/fonts/n021024l.pfb
displayFontT1 Helvetica             /usr/share/ghostscript/fonts/n019003l.pfb
displayFontT1 Helvetica-Oblique     /usr/share/ghostscript/fonts/n019023l.pfb
displayFontT1 Helvetica-Bold        /usr/share/ghostscript/fonts/n019004l.pfb
displayFontT1 Helvetica-BoldOblique /usr/share/ghostscript/fonts/n019024l.pfb
displayFontT1 Courier               /usr/share/ghostscript/fonts/n022003l.pfb
displayFontT1 Courier-Oblique       /usr/share/ghostscript/fonts/n022023l.pfb
displayFontT1 Courier-Bold          /usr/share/ghostscript/fonts/n022004l.pfb
displayFontT1 Courier-BoldOblique   /usr/share/ghostscript/fonts/n022024l.pfb
displayFontT1 Symbol                /usr/share/ghostscript/fonts/s050000l.pfb
displayFontT1 ZapfDingbats          /usr/share/ghostscript/fonts/d050000l.pfb
EOF

	make ${MAKEOPTS} || die
}


src_install() {
	# don't use builtin make install, as it doesn't compress manpages
	into /usr
	dodoc README ANNOUNCE CHANGES
	doman doc/*.[1-8]
	dobin xpdf/pdfimages xpdf/pdfinfo xpdf/pdftopbm
	dobin xpdf/pdftops xpdf/pdftotext xpdf/xpdf
	insinto /etc
	doins xpdfrc
}

pkg_postinst() {
	einfo
	einfo "HINT: To have even nicer results add these lines to your ~/.xpdfrc"
	einfo 
	einfo "  include         /etc/xpdfrc"
	einfo "  t1libControl    high"
	einfo "  freetypeControl high"
	einfo
}


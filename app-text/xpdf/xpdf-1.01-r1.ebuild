# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-text/xpdf/xpdf-1.01-r1.ebuild,v 1.2 2002/07/16 04:12:30 owen Exp $

S=${WORKDIR}/${P}
DESCRIPTION="An X Viewer for PDF Files"
SRC_URI="ftp://ftp.foolabs.com/pub/xpdf/${P}.tar.gz"
HOMEPAGE="http://www.foolabs.com/xpdf/xpdf.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

DEPEND="virtual/x11
	>=media-libs/freetype-2.0.9
	>=media-libs/t1lib-1.3
	app-text/ghostscript"

src_compile() {
	./configure --enable-freetype2 \
		--with-freetype2-library=/usr/lib \
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

	make || die
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


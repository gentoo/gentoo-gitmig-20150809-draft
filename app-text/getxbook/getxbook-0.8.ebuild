# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/getxbook/getxbook-0.8.ebuild,v 1.1 2012/02/15 08:45:36 grozin Exp $
EAPI=4
inherit eutils toolchain-funcs

DESCRIPTION="Download books from google, amazon, barnes and noble."
HOMEPAGE="http://njw.me.uk/software/getxbook/"
SRC_URI="http://njw.me.uk/software/getxbook/${P}.tar.bz2"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~x86"
IUSE="pdf djvu ocr tk"

DEPEND=""
RDEPEND="djvu? ( app-text/djvu )
	pdf? ( media-gfx/imagemagick )
	ocr? ( app-text/tesseract
		pdf? ( media-gfx/exact-image app-text/pdftk ) )
	tk? ( dev-lang/tk )"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-makefile.patch
}

src_compile() {
	tc-export CXX
	emake
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc README LEGAL
	exeinto /usr/bin
	use pdf  && doexe extras/mkpdf.sh
	use djvu && doexe extras/mkdjvu.sh
	if use tesseract; then
		doexe extras/mkocrtxt.sh
		use pdf  && doexe extras/mkocrpdf.sh
		use djvu && doexe extras/mkocrdjvu.sh
	fi
	use tk && doexe getxbookgui.tcl
}

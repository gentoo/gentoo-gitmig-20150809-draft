# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/tesseract/tesseract-2.03.ebuild,v 1.7 2009/05/11 16:59:59 ssuominen Exp $

inherit eutils

DESCRIPTION="A commercial quality OCR engine developed at HP in the 80's and early 90's."
HOMEPAGE="http://code.google.com/p/tesseract-ocr/"
SRC_URI="http://tesseract-ocr.googlecode.com/files/${P}.tar.gz
	linguas_de? ( http://tesseract-ocr.googlecode.com/files/${PN}-2.00.deu.tar.gz )
	linguas_de_FR? ( http://tesseract-ocr.googlecode.com/files/${PN}-2.01.deu-f.tar.gz )
	linguas_en? ( http://tesseract-ocr.googlecode.com/files/${PN}-2.00.eng.tar.gz )
	linguas_fr? ( http://tesseract-ocr.googlecode.com/files/${PN}-2.00.fra.tar.gz )
	linguas_it? ( http://tesseract-ocr.googlecode.com/files/${PN}-2.00.ita.tar.gz )
	linguas_nl? ( http://tesseract-ocr.googlecode.com/files/${PN}-2.00.nld.tar.gz )
	linguas_es? ( http://tesseract-ocr.googlecode.com/files/${PN}-2.00.spa.tar.gz )
	linguas_pt? ( http://tesseract-ocr.googlecode.com/files/${PN}-2.01.por.tar.gz )
	linguas_vi? ( http://tesseract-ocr.googlecode.com/files/${PN}-2.01.vie.tar.gz )"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="alpha amd64 ~mips ppc ppc64 sparc x86"
IUSE="tiff linguas_de linguas_de_FR linguas_en linguas_fr linguas_it linguas_nl \
linguas_es linguas_pt linguas_vi"

DEPEND="tiff? ( media-libs/tiff )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Includes for gcc 4.3
	epatch "${FILESDIR}"/includes.patch

	# Includes for gcc 4.4
	epatch "${FILESDIR}"/${P}-gcc44.patch

	# Move language files
	mv -f "${WORKDIR}"/tessdata/* tessdata/

	# Remove obsolete makefile, install target only in uppercase Makefile
	rm -f "${S}/java/makefile"

	sed -i -e "s:/usr/bin/X11/xterm:/usr/bin/xterm:" ccutil/debugwin.cpp
}

src_compile() {
	econf $(use_with tiff libtiff) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"

	dodoc README ReleaseNotes AUTHORS phototest.tif || die "dodoc failed"
}

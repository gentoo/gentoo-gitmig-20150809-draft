# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/cb2bib/cb2bib-1.4.2.ebuild,v 1.1 2010/10/06 20:22:26 chiiph Exp $

EAPI="2"

inherit qt4-r2

DESCRIPTION="Tool for extracting unformatted bibliographic references"
HOMEPAGE="http://www.molspaces.com/cb2bib/"
SRC_URI="http://www.molspaces.com/dl/progs/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
IUSE="debug +lzo +poll"

DEPEND="x11-libs/qt-webkit:4
	lzo? ( dev-libs/lzo )"
RDEPEND="${DEPEND}"

src_prepare() {
	echo "CONFIG += ordered" >> "${PN}.pro" || die "patching project file failed"
	sed -i 's:\.\./COPYRIGHT \.\.\/LICENSE::' src/src.pro || die "sed src.pro failed"
}

src_configure() {
	# Custom configure script has only few options, so call ./configure manually...
	# We need to unset QTDIR here, else we may end up with qt3 if it is installed.
	# TODO: remove QTDIR when qt3 goes away
	QTDIR="" ./configure \
		$(use_enable lzo) \
		$(use_enable poll cbpoll) \
		--disable-qmake-call \
		--qmakepath /usr/bin/qmake \
		--prefix /usr \
		--bindir /usr/bin \
		--datadir /usr/share \
		--desktopdatadir /usr/share/applications \
		--icondir /usr/share/pixmaps \
		|| die "cb2bib-provided configure failed"

	eqmake4 $(cat qmake-additional-args)
}

pkg_postinst() {
	elog "For best functionality, emerge the following packages:"
	elog "    app-text/poppler-utils  - for data import from PDF files"
	elog "    app-text/dvipdfm        - for data import from DVI files"
	elog "    app-text/bibutils       - for data import from ISI, endnote format"
	elog "    media-fonts/jsmath      - for displaying mathematical notation"
	elog "    media-libs/exiftool     - for proper UTF-8 metadata writing in PDF"
	elog "                              text strings"
	elog "    virtual/latex-base      - to check for BibTeX file correctness and to get"
	elog "                              nice printing through the shell script bib2pdf"
}

# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/clara/clara-20031214.ebuild,v 1.13 2006/09/16 16:57:40 spock Exp $

DESCRIPTION="An OCR (Optical Character Recognition) program"
SRC_URI="http://www.geocities.com/claraocr/clara-20031214.tar.gz"
HOMEPAGE="http://www.geocities.com/claraocr/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc ~ppc-macos x86"
IUSE=""

DEPEND="|| ( x11-libs/libX11 virtual/x11 )"

src_compile() {
	emake || die
	emake doc || die
}

src_install() {
	dobin clara selthresh
	doman doc/clara*.1 selthresh.1

	dodoc ANNOUNCE CHANGELOG doc/FAQ
	insinto /usr/share/doc/${P}
	doins imre.pbm

	dohtml doc/*.html
}

pkg_postinst() {
	einfo
	einfo "Please note that Clara OCR has to be trained to recognize text,"
	einfo "without a training session it simply won't work. Have a look at"
	einfo "the docs in /usr/share/doc/${P}/html/ to get more "
	einfo "info about the training procedure."
	einfo
}

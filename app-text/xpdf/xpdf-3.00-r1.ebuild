# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/xpdf/xpdf-3.00-r1.ebuild,v 1.7 2004/09/01 19:58:53 lu_zero Exp $

inherit eutils

DESCRIPTION="An X Viewer for PDF Files"
HOMEPAGE="http://www.foolabs.com/xpdf/"
SRC_URI="ftp://ftp.foolabs.com/pub/xpdf/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ppc ~sparc alpha hppa ~amd64 ~ia64 ppc64"
IUSE="motif cjk"

DEPEND="motif? ( virtual/x11
	x11-libs/openmotif )
	>=media-libs/freetype-2.0.5
	>=media-libs/t1lib-1.3
	virtual/ghostscript"

src_unpack() {
	unpack ${A}
	cd ${S}
	use cjk && epatch ${FILESDIR}/xpdf-3.00-truetype.diff.gz
}

src_compile() {
	econf \
		--enable-freetype2 \
		--with-freetype2-includes=/usr/include/freetype2 || die

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	prepallman
	dodoc README ANNOUNCE CHANGES
	insinto /etc
	doins ${FILESDIR}/xpdfrc
}

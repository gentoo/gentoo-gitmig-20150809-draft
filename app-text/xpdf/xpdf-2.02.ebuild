# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/xpdf/xpdf-2.02.ebuild,v 1.5 2003/09/05 22:37:22 msterret Exp $

IUSE="motif"

S=${WORKDIR}/${P}
DESCRIPTION="An X Viewer for PDF Files"
HOMEPAGE="http://www.foolabs.com/xpdf/xpdf.html"
SRC_URI="ftp://ftp.foolabs.com/pub/xpdf/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha ~mips ~hppa ~arm"

DEPEND="motif? ( virtual/x11
		virtual/motif )
	>=media-libs/freetype-2.0.5
	>=media-libs/t1lib-1.3
	app-text/ghostscript"

src_compile() {
	econf \
		--enable-freetype2 \
		--with-freetype2-includes=/usr/include/freetype2 \
		--with-gzip || die

	make ${MAKEOPTS} || die
}


src_install() {
	make DESTDIR=${D} install || die
	prepallman
	dodoc README ANNOUNCE CHANGES
	insinto /etc
	doins ${FILESDIR}/xpdfrc
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

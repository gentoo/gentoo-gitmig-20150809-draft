# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/xpdf/xpdf-2.03.ebuild,v 1.4 2004/01/11 13:42:02 lanius Exp $

MY_PV=${PV/.1/pl1}

S=${WORKDIR}/${PN}-${MY_PV}
DESCRIPTION="An X Viewer for PDF Files"
HOMEPAGE="http://www.foolabs.com/xpdf/xpdf.html"
SRC_URI="ftp://ftp.foolabs.com/pub/xpdf/${PN}-${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~mips hppa ~arm ~amd64 ~ia64"
IUSE="motif"

DEPEND="motif? ( virtual/x11
	x11-libs/openmotif )
	>=media-libs/freetype-2.0.5
	>=media-libs/t1lib-1.3
	virtual/ghostscript"

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

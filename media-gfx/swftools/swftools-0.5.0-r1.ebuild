# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/swftools/swftools-0.5.0-r1.ebuild,v 1.1 2004/02/13 15:33:20 rizzo Exp $

DESCRIPTION="SWF Tools is a collection of SWF manipulation and generation utilities"
HOMEPAGE="http://www.quiss.org/swftools/"
SRC_URI="http://www.quiss.org/swftools/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="avi"

DEPEND=">=media-libs/t1lib-1.3.1
		media-libs/jpeg
		media-libs/libpng
		avi? ( media-video/avifile )"
RDEPEND="app-text/xpdf
		 app-text/ttf2pt1
		 media-sound/lame"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/swftools-0.5.0-font.patch
}

src_compile() {
	econf || die "Configure failed."
	emake || die "Make failed."
}

src_install() {
	einstall || die "Install died."
	dodoc AUTHORS COPYING ChangeLog FAQ INSTALL TODO
}

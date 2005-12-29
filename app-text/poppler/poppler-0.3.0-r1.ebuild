# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/poppler/poppler-0.3.0-r1.ebuild,v 1.9 2005/12/29 04:56:34 vapier Exp $

inherit eutils

DESCRIPTION="Poppler is a PDF rendering library based on the xpdf-3.0 code base."
HOMEPAGE="http://poppler.freedesktop.org"
SRC_URI="http://poppler.freedesktop.org/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh ~sparc x86"
IUSE="gtk"

# cairo is in packages.mask
# qt does not compile

DEPEND=">=media-libs/freetype-2.0.5
	>=media-libs/t1lib-1.3
	virtual/ghostscript
	dev-util/pkgconfig
	media-libs/fontconfig
	gtk? ( =x11-libs/gtk+-2* )"

src_unpack(){
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-0.4.2-CAN-2005-3193.patch
}

src_compile() {
	econf --disable-poppler-qt --disable-cairo-output || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README AUTHORS ChangeLog NEWS README-XPDF TODO
}
